import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/user_controller.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/user_service.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {

  String? imageUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCurrentImage();
  }

  Future<void> fetchCurrentImage() async{
    final userDoc = await userService.value.getUserdata(authService.value.currentUser!.uid);
    setState(() {
      imageUrl = userDoc['profilePicture'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey,
          backgroundImage: (imageUrl != null && imageUrl!.trim().isNotEmpty)
              ? NetworkImage(imageUrl!)
              : null,
          child: (imageUrl == null || imageUrl!.trim().isEmpty)
              ? Icon(Icons.person, size: 60)
              : null,
        ),
        IconButton(onPressed: () async{
          final newUrl = await UserController().editProfilePicture();
          if(newUrl != null){
            setState(() {
              imageUrl = newUrl;
            });
          }
        }, icon: Icon(Icons.add_a_photo))
      ],
    );
  }

}
