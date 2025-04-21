import 'dart:io';

import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileImageScreen extends StatefulWidget {
  static const String routeName = '/update-profile-image';
  const UpdateProfileImageScreen({super.key});

  @override
  State<UpdateProfileImageScreen> createState() =>
      _UpdateProfileImageScreenState();
}

class _UpdateProfileImageScreenState extends State<UpdateProfileImageScreen> {
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
      1,
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
            left: 32.0,
            right: 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تعديل الصورة الشخصية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              CircleAvatar(
                radius: 96,
                backgroundImage:
                    pickedImage != null ? FileImage(pickedImage!) : null,
              ),
              Column(
                children: [
                  CustomElevatedButton(
                    label: 'اختيار صورة',
                    onPressed: pickImage,
                    backgroundColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 16.0),
                  CustomElevatedButton(
                    label: 'تحديث صورة الملف',
                    onPressed: updateProfileImage,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
