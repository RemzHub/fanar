import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final Icon? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double borderRadiusCircular;

  const CustomTextButton({
    super.key,
    required this.label,
    this.onPressed,
    this.borderRadiusCircular = 12,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusCircular),
        ),
        minimumSize: Size(double.infinity, 48),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
