import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<EntriesService> entryService = ValueNotifier(EntriesService());
class EntriesService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createNewEntry({
    required String uid,
    required String pid,
    required String text,
    required String feeling,
  }) async {
    final entryDoc =
        firestore
            .collection('users')
            .doc(uid)
            .collection('persons')
            .doc(pid)
            .collection('entries')
            .doc();
    await entryDoc.set({
      'eid': entryDoc.id,
      'text': text,
      'date': DateTime.now(),
      'feeling': feeling,
    });
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getAllEntries({
    required String uid,
    required String pid,
  })  {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .collection('entries')
        .orderBy('date',descending: true)
        .snapshots();
  }



  Future<void> deleteEntry({
    required String uid,
    required String pid,
    required String eid,
  }) async {
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .collection('entries')
        .doc(eid)
        .delete();
  }
}
