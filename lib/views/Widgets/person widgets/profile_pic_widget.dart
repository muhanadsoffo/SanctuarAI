import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicWidget extends StatefulWidget {
  final Function(File) onImagePicked;
  const ProfilePicWidget({super.key, required this.onImagePicked});

  @override
  State<ProfilePicWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final image= File(pickedFile.path);
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      widget.onImagePicked(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: CircleAvatar(
          radius: 65,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          child: _pickedImage == null ? Icon(Icons.person_add,size: 50,color: Colors.white,) : null,
        ),
      ),
    );
  }
}
