import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/user_controller.dart';

class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  bool isEditing = false;
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(
      text: FirebaseAuth.instance.currentUser?.displayName ?? "",
    );
    super.initState();
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> saveUsername() async {
    String name = nameController.text;
    if (name.isNotEmpty) {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      await UserController().updateUserName(name: name);
      setState(() {
        isEditing = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Name updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        SizedBox(width: 48),
        Flexible(
          child: Center( child:
            isEditing
                ? TextField(
              controller: nameController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: nameController.text,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                border: OutlineInputBorder(),
              ),
            )
                : Text(
              nameController.text.isNotEmpty
                  ? nameController.text
                  : "Your Name",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
            ),
          ),

        ),

        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit),
          onPressed: () {
            if (isEditing) {
              saveUsername();
            } else {
              toggleEdit();
            }
          },
        ),
      ],
    );
  }
}
