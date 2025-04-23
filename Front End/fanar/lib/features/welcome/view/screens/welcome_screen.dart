import 'package:fanar/core/constants/app_images.dart';
import 'package:fanar/core/network/network_status_controller.dart';
import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/test/screens/prepare_screen.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';
import 'package:fanar/features/auth/view/screens/auth_wrapper.dart';
import 'package:fanar/features/auth/view/screens/register_screen.dart';
import 'package:fanar/features/welcome/view/widgets/choose_path_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome_screen';

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // NetworkStatusController.to.test();
    Get.put(AuthController());
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => PrepareScreen()));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF02022F), Color(0xFF291571)],
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.25,
              width: screenSize.width,
              child: SvgPicture.asset(
                'assets/vectors/logo.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
