import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/user_service.dart';

class UserController {
  static final userController = UserController();

  //Todo: implement a function that updates the profile picture
  Future<String?> editProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final uid = authService.value.currentUser!.uid;
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

  //Todo: implement a function to update the name
}
