import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/view/screens/login_screen.dart';
import 'package:fanar/features/home/view/recruiter/screens/recruiter_homepage_screen.dart';
import 'package:fanar/features/home/view/screens/homepage_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthWrapper extends StatelessWidget {
  static String routeName = '/auth_wrapper';
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Obx(
      () {
        return authController.isAuthenticated.value
            ? authController.isPerformer.value
                ? HomepageScreen()
                : RecruiterHomepageScreen()
            : LoginScreen();
      },
    );
  }
}
