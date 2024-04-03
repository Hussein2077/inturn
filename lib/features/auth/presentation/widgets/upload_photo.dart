import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inturn/core/utils/app_size.dart';

class UploadProfileImagePage extends StatefulWidget {
  const UploadProfileImagePage({super.key});

  @override
  UploadProfileImagePageState createState() => UploadProfileImagePageState();
}

class UploadProfileImagePageState extends State<UploadProfileImagePage> {
  File? _imageFile;

  void _openImagePicker() async {
    // final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    // setState(() {
    //   if (pickedImage != null) {
    //     _imageFile = File(pickedImage.path);
    //   } else {
    //     print('No image selected.');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openImagePicker,
      child: Container(
        width: AppSize.defaultSize! * 10,
        height:  AppSize.defaultSize! * 10,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular( AppSize.defaultSize! * 7.5),

        ),
        child: _imageFile != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular( AppSize.defaultSize! * 7.5),
          child: Image.file(
            _imageFile!,
            width:   AppSize.defaultSize! * 10,
            height:  AppSize.defaultSize! * 10,
            fit: BoxFit.cover,
          ),
        )
            : Icon(
          Icons.person,
          size:  AppSize.defaultSize! * 6,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}