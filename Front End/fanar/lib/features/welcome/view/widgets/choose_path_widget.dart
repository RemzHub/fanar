import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/user_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePathWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String nextPagePath;
  final Color? color;
  final UserType userType;
  const ChoosePathWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.nextPagePath,
    this.color,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return GestureDetector(
      onTap: () {
        authController.updateUserType(userType);
        Get.toNamed(nextPagePath);
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color ?? Colors.black,
              color?.withOpacity(0.2) ?? Colors.black12,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
