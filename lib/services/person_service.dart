import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
ValueNotifier<PersonService> personService = ValueNotifier(PersonService());
class PersonService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createNewPerson({
    required String uid,
    required String name,
    required String gender,
    required String intro,
    String? personPicture,
  }) async {
    final personDoc =
        firestore.collection('users').doc(uid).collection('persons').doc();
    await personDoc.set({
      'pid' : personDoc.id,
      'uid': uid,
      'name': name,
      'gender': gender,
      'intro': intro,
      'personPicture': personPicture ?? "",
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPersons(String uid) async{
    return await firestore.collection('users').doc(uid).collection('persons').get();
  }
}
