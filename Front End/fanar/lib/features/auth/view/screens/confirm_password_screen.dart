import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/core/utils/dialog_manager.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/view/screens/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  static const String routeName = '/confirm_password_screen';
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreen();
}

class _ConfirmPasswordScreen extends State<ConfirmPasswordScreen> {
  final authController = Get.find<AuthController>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  void register() async {
    final verified = formKey.currentState!.validate();
    if (verified) {
      authController.updatePassword(passwordController.text);
      final result = await authController.register();
      if (result.$1) {
        Get.offNamed(AuthWrapper.routeName);
        authController.login(
          authController.user.username,
          authController.user.password,
        );
      } else {
        DialogManager().showSnackBar('خطأ', result.$2);
      }
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default appBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: appBarHeight + statusBarHeight,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'بقيت خطوة واحدة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'قم بتعيين كلمة المرور، يجب أن تتكون من 8 خانات',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      title: 'كلمة المرور',
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                      ),
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length >= 8) {
                          return null;
                        }
                        return 'طول كلمة المرور 8 خانات على الأقل';
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      title: 'تأكيد كلمة المرور',
                      prefixIcon: Icons.lock_person,
                      controller: confirmPasswordController,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                      ),
                      validator: (value) {
                        print(value);
                        print(passwordController.text);
                        if (value != null &&
                            value.isNotEmpty &&
                            value == passwordController.text) {
                          return null;
                        }
                        return 'طول كلمة المرور 8 خانات على الأقل';
                      },
                    ),
                    const SizedBox(height: 32.0),
                    CustomElevatedButton(
                      label: 'تسجيل حساب جديد',
                      onPressed: () {
                        register();
                      },
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
