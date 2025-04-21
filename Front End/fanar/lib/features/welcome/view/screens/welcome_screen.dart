import 'package:fanar/core/constants/app_images.dart';
import 'package:fanar/core/network/network_status_controller.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';
import 'package:fanar/features/auth/view/screens/auth_wrapper.dart';
import 'package:fanar/features/auth/view/screens/register_screen.dart';
import 'package:fanar/features/welcome/view/widgets/choose_path_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome_screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NetworkStatusController.to.test();
    Get.put(AuthController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  AppImages.appLogo,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                ' اختر مسارك',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoosePathWidget(
                    icon: Icons.recent_actors_outlined,
                    label: 'نجم موهوب',
                    nextPagePath: RegisterScreen.routeName,
                    color: Color.fromARGB(255, 115, 178, 255),
                    userType: UserType(id: 5, name: 'performer'),
                  ),
                  const SizedBox(width: 24),
                  ChoosePathWidget(
                    icon: Icons.movie_outlined,
                    label: 'مُكتشف',
                    nextPagePath: RegisterScreen.routeName,
                    color: Color.fromARGB(255, 186, 0, 0),
                    userType: UserType(id: 4, name: 'recruiter'),
                  ),
                ],
              ),
              const SizedBox(height: 64.0),
              RichText(
                text: TextSpan(
                  text: 'لديك حساب بالفعل؟ ',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'تسجيل دخول',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(AuthWrapper.routeName),
                    ),
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
