import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/user_service.dart';
import 'package:sanctuarai/views/pages/persons%20pages/persons_page.dart';
import 'package:sanctuarai/views/pages/profile%20pages/profile_page.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: userService.value.getUserdata(authService.value.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(); // Or a loading indicator
        }

        if (!snapshot.hasData || snapshot.data == null || snapshot.data!.data() == null) {
          return Text("No user data found");
        }

        final data = snapshot.data!.data()!;
        final imageUrl = data['profilePicture'] as String? ?? '';
        final name = data['name'] as String? ?? 'Unknown';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  backgroundImage: imageUrl.trim().startsWith('http')
                      ? NetworkImage(imageUrl)
                      : null,
                  child: (!imageUrl.trim().startsWith('http'))
                      ? Icon(Icons.person, size: 30)
                      : null,
                ),
                SizedBox(width: 10),
                Text(name, style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        );
      },
    );
  }
}
