import 'dart:math';

import 'package:fanar/features/welcome/view/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ClipPath(
            clipper: CustomClip(),
            child: Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.45),
              color: Colors.black12,
            ),
          ),
          Positioned(
            top: screenSize.height * 0.25,
            width: screenSize.width,
            child: SvgPicture.asset('assets/vectors/logo.svg'),
          ),
          Positioned(
            bottom: 32.0,
            left: screenSize.width * 0.2,
            child: Stack(
              children: [
                SplashCard(
                  key: UniqueKey(),
                  image: 'assets/images/splash_card_one.jpg',
                  position: cardPosition.left,
                ),
                SplashCard(
                  key: UniqueKey(),
                  image: 'assets/images/splash_card_two.jpg',
                  position: cardPosition.right,
                ),
                SplashCard(
                  key: UniqueKey(),
                  image: 'assets/images/splash_card_three.jpg',
                  position: cardPosition.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.55);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.35,
      size.width,
      size.height * 0.55,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

enum cardPosition { left, center, right }

class SplashCard extends StatelessWidget {
  final String image;
  final cardPosition position;

  Matrix4 getTransform(cardPosition position) {
    if (position == cardPosition.left) {
      return Matrix4.identity()
        ..translate(200.0, 0.0)
        ..rotateZ(pi / 8);
    } else if (position == cardPosition.right) {
      return Matrix4.identity()
        ..translate(-200.0, 0.0)
        ..rotateZ(pi / -8);
    }
    return Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: getTransform(position),
      child: Container(
        height: 350,
        width: 220,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  const SplashCard({super.key, required this.image, required this.position});
}
