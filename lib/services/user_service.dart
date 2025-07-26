import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:sanctuarai/services/auth_service.dart';

ValueNotifier<UserService> userService = ValueNotifier(UserService());

class UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
    String? profilePicture,
    String? bio,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
      'profilePicture': profilePicture ?? '',
      'bio': bio ?? '',
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserdata(String uid) async {
    return await firestore.collection('users').doc(uid).get();
  }

  //Todo: implement a function to update the profile picture
  Future<String?> updateProfilePicture({
    required String uid,
    required File imageFile,
  }) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dnbyfymlx/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'SanctuarAI';
    request.fields['folder'] = 'users';


    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      firestore.collection('users').doc(uid).update({
        'profilePicture': jsonMap['secure_url'],
      });
      return jsonMap['secure_url'];
    } else {
      print("failed to uploaaaaaaaad : ${response.statusCode}");
      return null;
    }
  }

  //Todo: implement a function to update the bio

  Future<void> updateBio({required String uid, required String bio}) async {
    await firestore.collection('users').doc(uid).update({'bio': bio});
  }

  //Todo: implement a function to update the name
  Future<void> updateName({
    required String uid,
    required String newName,
  }) async {
    await firestore.collection('users').doc(uid).update({'name': newName});
  }
}
