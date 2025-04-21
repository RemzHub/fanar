import 'package:fanar/core/common/controller/supported_country_controller.dart';
import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/common/widgets/custom_phone_field.dart';
import 'package:fanar/core/common/widgets/custom_text_form_field.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/core/utils/dialog_manager.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/view/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register_screen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final authController = Get.find<AuthController>();
  final supportedCountryController = Get.find<SupportedCountryController>();

  void updateUser() async {
    final valid = formKey.currentState?.validate() ?? false;

    if (valid) {
      final isUserChecked =
          await authController.checkUsername(usernameController.text);
      print(isUserChecked);
      if (!isUserChecked) {
        DialogManager().showSnackBar('خطأ', 'أسم المستخدم غير متاح');
        return;
      }
      final isPhoneChecked = await authController.checkPhone(
          '${supportedCountryController.country.phoneCode}${phoneController.text}');
      print(isPhoneChecked);
      if (!isPhoneChecked) {
        DialogManager().showSnackBar('خطأ', 'رقم الجوال غير متاح');
        return;
      }
      formKey.currentState!.save();
      authController.updateUsernameAndPhone(
        usernameController.text,
        '${supportedCountryController.country.phoneCode}${phoneController.text}',
        authController.user.userType,
      );

      final isSentOTP = await authController.sendOTP();
      if (isSentOTP) {
        Get.toNamed(OTPScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default AppBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final authController = Get.find<AuthController>();
    final user = authController.user;

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
              if (user.userType.id == 5)
                Column(
                  children: const [
                    Text(
                      'تسجيل حساب موهوب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'قم بتسجيل حسابك الآن، و استمتع بالكثير من المزايا والدورات، زد فرص نجاحك بالحصول على أدوار صممت من أجلك.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              if (user.userType.id == 4)
                Column(
                  children: const [
                    Text(
                      'تسجيل حساب مكتشف مواهب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'أبحث بين المواهب، اعرض جديد الفرص والادوار.',
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
                    SizedBox(height: 16),
                    CustomTextFormField(
                      controller: usernameController,
                      title: 'اسم المستخدم',
                      hintText: 'username',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return null;
                        }
                        return 'اسم المستخدم لا يمكن أن يكون فارغ';
                      },
                    ),
                    SizedBox(height: 16),
                    CustomPhoneField(
                      controller: phoneController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value[0] == '5') {
                          return null;
                        }
                        return 'يجب أن يبدأ الرقم بـ 5 رقمك غير صالح';
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48.0),
              CustomElevatedButton(
                onPressed: updateUser,
                label: 'تسجيل حساب جديد',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
