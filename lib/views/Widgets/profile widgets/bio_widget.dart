import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sanctuarai/controllers/user_controller.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/user_service.dart';

class BioWidget extends StatefulWidget {
  const BioWidget({super.key});

  @override
  State<BioWidget> createState() => _BioWidgetState();
}

class _BioWidgetState extends State<BioWidget> {
  bool isEditing = false;
  late TextEditingController bioController;
  String? bio;

  @override
  void initState() {
    super.initState();
    bioController = TextEditingController();
    loadBio();
  }

  Future<void> loadBio() async {
    final uid = authService.value.currentUser?.uid;
    if (uid != null) {
      final doc = await userService.value.getUserdata(uid);
      setState(() {
        bio = doc['bio'] ?? "";
        bioController.text = bio!;
      });
    }
  }

  void toggleEdit() {
    setState(() => isEditing = !isEditing);
  }

  Future<void> saveBio() async {
    final newBio = bioController.text;
    final error = await UserController().updateUserBio(bio: newBio);
    if (error == null) {

      setState(() {
        bio = newBio;
        isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bio updated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Bio", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit),
                onPressed: () => isEditing ? saveBio() : toggleEdit(),
              )
            ],
          ),
          isEditing
              ? TextField(
            controller: bioController,
            maxLines: null,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Enter your bio...",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(8),
            ),
          )
              : Text(
            bio ?? "",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
