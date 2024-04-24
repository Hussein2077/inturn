import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inturn/core/utils/app_size.dart';

class UploadProfileImagePage extends StatefulWidget {
  const UploadProfileImagePage({super.key});
static File? imageFile;
  @override
  UploadProfileImagePageState createState() => UploadProfileImagePageState();
}

class UploadProfileImagePageState extends State<UploadProfileImagePage> {


  void _openImagePicker() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        UploadProfileImagePage.imageFile = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
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
        child: UploadProfileImagePage.imageFile != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular( AppSize.defaultSize! * 7.5),
          child: Image.file(
            UploadProfileImagePage.imageFile!,
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