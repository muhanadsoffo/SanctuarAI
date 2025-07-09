import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/openai_service.dart';
import 'package:sanctuarai/services/person_service.dart';

class OpenaiController {
  final uid = authService.value.currentUser!.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> sendForFirstTime({required String pid}) async {
    try {
      final personDetails = await personService.value.getPersonDetails(pid);
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
''';
      final response = await openaiService.value.sendMessageToGpt(prompt);
      if(response == null){
        return "Failed to get response from AI.";
      }
      await firestore.collection('users')
          .doc(uid)
          .collection('persons')
          .doc(pid)
          .update({
        'summary': response,
        'lastSummarizedAt': FieldValue.serverTimestamp(),
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> followUp({required String pid}) async {
    try {
      final personDetails = await personService.value.getPersonDetails(pid);
      final lastSummaryTime = personDetails['lastSummarizedAt'];
      final newEntries =
      await firestore
          .collection('users')
          .doc(uid)
          .collection('persons')
          .doc(pid)
          .collection('entries')
          .where('date', isGreaterThan: lastSummaryTime)
          .get();
    } catch (e) {
      return e.toString();
    }
  }
}
