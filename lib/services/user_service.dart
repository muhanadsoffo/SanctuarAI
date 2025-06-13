import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

ValueNotifier<UserService> userService = ValueNotifier(UserService());

class UserService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile({
    required String uid,
    required String name,
    required String email,
    String? profilePicture,
    String? bio

}) async{
    await firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
      'profilePicture': profilePicture ?? '',
      'bio' : bio ?? '',
    });
  }


  Future<DocumentSnapshot> getUserdata(String uid) async{
    return await firestore.collection('users').doc(uid).get();
  }

}