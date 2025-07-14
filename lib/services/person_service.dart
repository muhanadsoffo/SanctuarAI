import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sanctuarai/services/auth_service.dart';

ValueNotifier<PersonService> personService = ValueNotifier(PersonService());

class PersonService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final uid = authService.value.currentUser!.uid;

  Future<void> createNewPerson({
    required String uid,
    required String name,
    required String gender,
    required String intro,
    String? personPicture,
    String? summary,
    String? advice,
    DateTime? lastSummarizedAt,
    int? entryNumber,
  }) async {
    final personDoc =
        firestore.collection('users').doc(uid).collection('persons').doc();
    await personDoc.set({
      'pid': personDoc.id,
      'uid': uid,
      'name': name,
      'gender': gender,
      'intro': intro,
      'personPicture': personPicture ?? "",
      'summary': summary ?? "",
      'advice': advice ?? "",
      'lastSummarizedAt': lastSummarizedAt ?? "",
      'entryNumber': entryNumber ?? 0,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPersons(String uid) async {
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPersonDetails({
    required String pid,
    String? uid
  }) async {
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .get();
  }

  Future<void> deletePerson(String pid) async {
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .delete();
  }

  Future<void> updateOnResponse({
    required String summary,
    required String advice,
    required String pid,
  }) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .update({
          'aiResponse': {
            'summary': summary,
            'advice': advice,
            'lastSummarizedAt': Timestamp.now(),
          },
        });
  }

  Future<void> updateEntryNumber({
    required String pid,
    required int number,
  }) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .update({'entryNumber': FieldValue.increment(number)});
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPersonsWithMostEntries({
    required String uid,
  }) async {
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .orderBy('entryNumber', descending: true)
        .limit(5)
        .get();
  }
}
