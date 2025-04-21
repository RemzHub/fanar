import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final bool first;
  final bool last;
  const OTPFieldWidget({
    super.key,
    required this.controller,
    this.first = false,
    this.last = false,
  }) : autoFocus = first;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () {
        controller.selection =
            TextSelection.collapsed(offset: controller.text.length);
      },
      onChanged: (value) {
        if (value.isNotEmpty && !last) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty && !first) FocusScope.of(context).previousFocus();
      },
      autofocus: autoFocus,
      textAlign: TextAlign.center,
      maxLength: 1,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
      cursorHeight: 32.0,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        counterText: '',
        constraints: BoxConstraints(
          maxWidth: 48.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white70,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white70,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white70,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 2,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
