import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sanctuarai/services/auth_service.dart';

ValueNotifier<PersonService> personService = ValueNotifier(PersonService());

class PersonService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createNewPerson({
    required String uid,
    required String name,
    required String gender,
    required String intro,
    required File personPicture,
    String? summary,
    String? advice,
    DateTime? lastSummarizedAt,
    int? entryNumber,
  }) async {
    final uid = authService.value.currentUser!.uid;
    final personDoc =
        firestore.collection('users').doc(uid).collection('persons').doc();
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dnbyfymlx/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'sanctuarAI_persons';
    request.fields['folder'] = 'persons';

    request.files.add(
      await http.MultipartFile.fromPath('file', personPicture.path),
    );
    final response = await request.send();
    Map<String, dynamic>? jsonMap;
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
       jsonMap = jsonDecode(responseString);
    }
    if (jsonMap == null || !jsonMap.containsKey('secure_url')) {
      throw Exception('Failed to upload image to Cloudinary');
    }
    await personDoc.set({
      'pid': personDoc.id,
      'uid': uid,
      'name': name,
      'gender': gender,
      'intro': intro,
      'personPicture': jsonMap['secure_url'],
      'entryNumber': entryNumber ?? 0,
      "aiResponse": {
        "advice": advice,
        "summary": summary,
        'lastSummarizedAt': lastSummarizedAt ?? "",
      },
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPersons(String uid) async {
    final uid = authService.value.currentUser!.uid;
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPersonDetails({
    required String pid,
  }) async {
    final uid = authService.value.currentUser!.uid;
    return await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .get();
  }

  Future<void> deletePerson(String pid) async {
    final uid = authService.value.currentUser!.uid;
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
    final uid = authService.value.currentUser!.uid;
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
    final uid = authService.value.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .doc(pid)
        .update({'entryNumber': FieldValue.increment(number)});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPersonsWithMostEntries({
    required String uid,
  }) {
    final uid = authService.value.currentUser!.uid;
    return firestore
        .collection('users')
        .doc(uid)
        .collection('persons')
        .where('entryNumber', isGreaterThan: 0)
        .orderBy('entryNumber', descending: true)
        .limit(5)
        .snapshots();
  }

  Future<String?> updatePersonPicture({
    required String uid,
    required String pid,
    required File imageFile,
  }) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dnbyfymlx/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'sanctuarAI_persons';
    request.fields['folder'] = 'persons';

    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      firestore
          .collection('users')
          .doc(uid)
          .collection('persons')
          .doc(pid)
          .update({'personPicture': jsonMap['secure_url']});
      return jsonMap['secure_url'];
    } else {
      print("failed to uploaaaaaaaad : ${response.statusCode}");
      return null;
    }
  }
}
