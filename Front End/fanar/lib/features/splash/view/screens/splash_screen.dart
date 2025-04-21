import 'package:fanar/core/constants/app_images.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/welcome/view/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the welcome screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(WelcomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: Image.asset(AppImages.appLogo),
              ),
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(AppImages.appName),
              ),
              SizedBox(
                height: 40,
                width: 150,
                child: Image.asset(AppImages.spotLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
