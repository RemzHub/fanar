import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/core/utils/dialog_manager.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/welcome/view/screens/welcome_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  void login() async {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      final result = await AuthController.to
          .login(usernameController.text, passwordController.text);
      if (!result.$1) {
        DialogManager().showSnackBar('خطأ', result.$2);
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: const [
                  Text(
                    'حياك الله ⭐🌆',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'سجل دخولك الآن، تصفح جديد الفرص.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      title: 'أسم المستخدم',
                      controller: usernameController,
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return 'اسم المستخدم لا يمكن أن يكون فارغ';
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      title: 'كلمة المرور',
                      controller: passwordController,
                      obscureText: isObscure,
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return 'كلمة المرور لا يمكن أن تكون فارغة';
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48.0),
              CustomElevatedButton(
                onPressed: () => login(),
                label: 'تسجيل دخول',
              ),
              const SizedBox(height: 64.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'لم تسجل حسابك بعد؟ ',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'تسجيل حساب جديد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.offNamed(WelcomeScreen.routeName),
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
