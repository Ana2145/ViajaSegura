import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeUserPhoto extends StatefulWidget {
  const ChangeUserPhoto({super.key});

  @override
  State<ChangeUserPhoto> createState() => _ChangeUserPhotoState();
}

class _ChangeUserPhotoState extends State<ChangeUserPhoto> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = pickedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Avatar
            CircleAvatar(
              radius: 80,
              backgroundImage: _image == null
                  ? const AssetImage('assets/images/default_avatar.png')
                  : FileImage(File(_image!.path)) as ImageProvider,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.focusColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.canvasColor, width: 2),
                  ),
                  child: Icon(Icons.edit, color: theme.canvasColor, size: 20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
