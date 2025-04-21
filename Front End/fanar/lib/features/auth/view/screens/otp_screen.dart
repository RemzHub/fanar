import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/view/screens/confirm_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  static const String routeName = '/otp_screen';
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final authController = Get.find<AuthController>();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  void checkOTP(String code) async {
    bool verified = await authController.checkOTP(code);
    formKey.currentState!.validate();
    if (verified) {
      Get.offAllNamed(ConfirmPasswordScreen.routeName);
    }
    // TODO: fix focus when the pinput clear fields
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    otpController.dispose();
    focusNode.dispose();
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
                'التحقق من رقم الجوال',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${authController.user.phone} :',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'تم إرسال رمز التحقق إلى الرقم',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Pinput(
                        focusNode: focusNode,
                        length: 6,
                        autofocus: true,
                        controller: otpController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        defaultPinTheme: PinTheme(
                          textStyle: TextStyle(
                            fontSize: 36.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          width: 42.0,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white30,
                            ),
                          ),
                          height: 58.0,
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value == authController.otp) {
                            return null;
                          }
                          otpController.clear();
                          return null;
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onCompleted: (value) {
                          print('onCompleted: pinput');
                          print(value);
                          checkOTP(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
