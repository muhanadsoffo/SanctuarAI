import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(authService.value.currentUser!.uid)
        .get();

    setState(() {
      userData = doc.data();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData == null) return SizedBox();

    final imageUrl = userData?['profilePicture'] ?? '';
    final name = userData?['name'] ?? 'Unknown';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: imageUrl.trim().isNotEmpty
                  ? CachedNetworkImageProvider(imageUrl)
                  : null,
              child: imageUrl.trim().isEmpty
                  ? Icon(Icons.person, size: 30)
                  : null,
            ),
            SizedBox(width: 10),
            Text(name, style: TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }
}
