import 'dart:io';

import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadGalleryImage extends StatefulWidget {
  static const String routeName = '/upload-gallery-image';
  const UploadGalleryImage({super.key});

  @override
  State<UploadGalleryImage> createState() => _UploadGalleryImageState();
}

class _UploadGalleryImageState extends State<UploadGalleryImage> {
  File? pickedImage;
  void pickImage() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          pickedImage = File(file.path);
        });
      }
    } catch (error) {
      print(error);
    }
  }

  void updateProfileImage() async {
    final result = await AuthController.to.uploadMedia(
      pickedImage!,
      2,
    );
    print(result);
    if (result.$1) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default AppBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: appBarHeight + statusBarHeight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تحديث صور المعرض',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.blueGrey,
                child: pickedImage != null
                    ? Image.file(
                        pickedImage!,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                ),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      label: 'اختيار صورة',
                      onPressed: pickImage,
                      backgroundColor: Colors.blueAccent,
                    ),
                    const SizedBox(height: 16.0),
                    CustomElevatedButton(
                      label: 'رفع صورة إلى المعرض',
                      onPressed: updateProfileImage,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
