import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String? initialValue;
  final IconData? prefixIcon;
  final bool obscureText;
  final String? hintText;
  final int? maxLength;
  final int? minLines;
  final int maxLines;
  final bool readOnly;
  final bool? enabled;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    required this.title,
    this.initialValue,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled,
    this.inputFormatters,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          style: const TextStyle(color: Colors.white),
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          readOnly: readOnly,
          enabled: enabled,
          inputFormatters: inputFormatters,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
            counterStyle: TextStyle(color: Colors.white),
            filled: true,
            fillColor: const Color.fromARGB(255, 56, 89, 123),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white70)
                : null,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
