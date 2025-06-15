import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path ;
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

  Future<DocumentSnapshot> getUserdata(String uid) async {
    return await firestore.collection('users').doc(uid).get();
  }

  //Todo: implement a function to update the profile picture
  Future<String?> updateProfilePicture({
    required String uid,
    required File imageFile,
  }) async {
    String extension = path.extension(imageFile.path);
    //here we are creating a folder named profile_pictures if it doesn't exist and creating a unique filename for the user's picture
    final ref = storage.ref().child('profile_pictures').child('$uid$extension');
    await ref.putFile(imageFile);
    final imageUrl = await ref.getDownloadURL();
    await firestore.collection('users').doc(uid).update({
      'profilePicture': imageUrl,
    });
    return imageUrl;
  }

  //Todo: implement a function to update the bio

Future<void> updateBio({
    required String uid,
  required String bio
})async{
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'bio' : bio
    });
}

  //Todo: implement a function to update the name
}
