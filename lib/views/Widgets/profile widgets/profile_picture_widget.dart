import 'package:flutter/material.dart';
import 'package:sanctuarai/services/user_service.dart'; // Adjust import path
import 'package:sanctuarai/services/auth_service.dart'; // Adjust import path
import 'package:sanctuarai/controllers/user_controller.dart'; // Adjust import path

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchCurrentImage();
  }

  Future<void> fetchCurrentImage() async {
    final uid = authService.value.currentUser!.uid;
    final userDoc = await userService.value.getUserdata(uid);
    setState(() {
      imageUrl = userDoc['profilePicture'];
    });
  }

  Future<void> handleImageUpdate() async {
    final uid = authService.value.currentUser!.uid;
    try {
      await userService.value.updateProfilePicture(uid: uid); // Uploads + updates Firestore
      await fetchCurrentImage(); // Refresh image from Firestore
    } catch (e) {
      print("❌ Failed to update profile picture: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile picture')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: (imageUrl != null && imageUrl!.trim().isNotEmpty)
              ? NetworkImage(imageUrl!)
              : null,
          child: (imageUrl == null || imageUrl!.trim().isEmpty)
              ? const Icon(Icons.person, size: 60)
              : null,
        ),
        IconButton(
          onPressed: handleImageUpdate,
          icon: const Icon(Icons.add_a_photo, color: Colors.white),
          tooltip: 'Change Profile Picture',
        ),
      ],
    );
  }
}
