import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cached_network_image.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/profile/presentation/profile_screen.dart';

class UploadProfileImagePage extends StatefulWidget {
  const UploadProfileImagePage(
      {super.key, this.imagePath, this.isProfile = false});

  static File? imageFile;
  final String? imagePath;
  final bool? isProfile;

  @override
  UploadProfileImagePageState createState() => UploadProfileImagePageState();
}

class UploadProfileImagePageState extends State<UploadProfileImagePage> {
  var maxFileSizeInBytes = 5 * 1048576;

  void _openImagePicker() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var imagePath = await pickedImage!.readAsBytes();

    var fileSize = imagePath.length; // Get the file size in bytes
    if (fileSize <= maxFileSizeInBytes) {
      setState(() {
        if (pickedImage != null) {
          if (widget.isProfile == true) {
            ProfileScreen.isUploaded = true;
            log('messagemessagemessage');
          }
          UploadProfileImagePage.imageFile = File(pickedImage.path);
        } else {
          print('No image selected.');
        }
      });

    } else {
      errorSnackBar(context, StringManager.fileTooBig.tr());
    }
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openImagePicker,
      child: Container(
        width: AppSize.defaultSize! * 10,
        height: AppSize.defaultSize! * 10,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(AppSize.defaultSize! * 7.5),
        ),
        child: (UploadProfileImagePage.imageFile != null)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 7.5),
                child: (widget.imagePath != null && ProfileScreen.isUploaded)
                    ? CachedNetworkCustom(url: widget.imagePath!)
                    : Image.file(
                        UploadProfileImagePage.imageFile!,
                        width: AppSize.defaultSize! * 10,
                        height: AppSize.defaultSize! * 10,
                        fit: BoxFit.cover,
                      ),
              )
            : widget.imagePath != null
                ? CachedNetworkCustom(url: widget.imagePath!)
                : Icon(
                    Icons.person,
                    size: AppSize.defaultSize! * 6,
                    color: Colors.grey[400],
                  ),
      ),
    );
  }
}
