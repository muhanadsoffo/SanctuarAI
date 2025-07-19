import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/openai_service.dart';
import 'package:sanctuarai/services/person_service.dart';

class OpenaiController {
  static final openaiController= OpenaiController();

  final uid = authService.value.currentUser!.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> sendForFirstTime({required String pid}) async {
    try {
      final personDetails = await personService.value.getPersonDetails(pid: pid);
      final name = personDetails['name'];
      final intro = personDetails['intro'];
      final newEntries =
          await firestore
              .collection('users')
              .doc(uid)
              .collection('persons')
              .doc(pid)
              .collection('entries')
              .get();
      if (newEntries.docs.isEmpty) {
        return "No Entries to send and get response";
      }
      final entries = newEntries.docs
          .map((doc) {
            final data = doc.data();
            final date = data['date'].toDate();
            final feeling = data['feeling'];
            final text = data['text'];
            return "- ${date.toLocal()} $text, $feeling";
          })
          .join('\n');
      final prompt = '''
You are a helpful AI therapist. A user has been writing about their interactions with someone named "$name". This person is a $intro.

Here are some events they've experienced with $name:

$entries

Based on the above, please summarize the relationship dynamics and provide any helpful advice or reflection.
Be aware that the summarize should definitely include the name of the person and the relationship type first, and should be around 200 character long. 
Please return a JSON object with two fields:
{
  "summary": "",
  "advice": ""
}
If the entries seem random or irrelevant, respond with: 
"I'm not able to provide helpful advice based on the current entries. Please provide more meaningful information."
''';
      final response = await openaiService.value.sendMessageToGpt(prompt,pid);
      if(response == null){
        return "Failed to get response from AI.";
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> followUp({required String pid}) async {
    try {
      final personDetails = await personService.value.getPersonDetails(pid: pid);
      final Timestamp  lastSummaryTime = personDetails['aiResponse.lastSummarizedAt'];
      final previousSummary = personDetails['aiResponse.summary'];
      final newEntries =
      await firestore
          .collection('users')
          .doc(uid)
          .collection('persons')
          .doc(pid)
          .collection('entries')
          .where('date', isGreaterThan: lastSummaryTime)
          .get();
      if (newEntries.docs.isEmpty) {
        return "No new entries to analyze.";
      }
      final entries = newEntries.docs
          .map((doc) {
        final data = doc.data();
        final date = data['date'].toDate();
        final feeling = data['feeling'];
        final text = data['text'];
        return "- ${date.toLocal()} $text, $feeling";
      })
          .join('\n');

      final prompt = '''
You are a helpful AI therapist.

The user previously shared several events about their relationship with someone. You provided the following summary and advice:

Previous Summary:
"$previousSummary"

New entries about their interactions with the same person have been recorded:

$entries

Please revise the summary to reflect the overall relationship, **incorporating the new entries**, but keeping the **person's name and relationship type** consistent with the original.

Return your updated insights as a JSON object with the following structure:
{
  "summary": "", 
  "advice": ""
}

If the new entries are too vague or irrelevant to the relationship, respond with:
"I'm not able to provide helpful advice based on the current entries. Please provide more meaningful information."
''';
      final response = await openaiService.value.sendMessageToGpt(prompt,pid);
      if(response == null){
        return "Failed to get response from AI.";
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
