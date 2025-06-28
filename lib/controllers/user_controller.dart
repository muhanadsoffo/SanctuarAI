import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/user_service.dart';

class UserController {
  static final userController = UserController();
  final uid = authService.value.currentUser!.uid;

  //Todo: implement a function that updates the profile picture
  Future<String?> editProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return null;
    }
    final imageFile = File(pickedFile.path);
    try {
      final imageUrl = await userService.value.updateProfilePicture(
        uid: uid,
        imageFile: imageFile,
      );
      return imageUrl;
    } catch (e) {
      return "unknown error";
    }
  }

  //Todo: implement a function to update the bio
  Future<String?> updateUserBio({required String bio}) async {
    if (bio.isEmpty || uid.isEmpty) {
      return "invalid info or you're not logged in";
    }
    try {
      await userService.value.updateBio(uid: uid, bio: bio.trim());
      return null;
    } catch (e) {
      return "Failed to update $e";
    }
  }

  //Todo: implement a function to update the name

  Future<String?> updateUserName({required String name}) async {
    if (name.isEmpty) {
      return "please fill the information";
    }
    try {
      await userService.value.updateName(uid: uid, newName: name);
      return null;
    } catch (e) {
      return "Failed to update the name";
    }
  }
}
