import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Color fillColor;
  final double borderRadius;
  final Color borderColor;        // ✅ NEW
  final Color focusedBorderColor; // ✅ NEW

  const CommonTextField({
    super.key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.suffix,
    this.fillColor = const Color(0xff2b2b2b),
    this.borderRadius = 12,
    this.borderColor = Colors.grey,           // ✅ default color
    this.focusedBorderColor = Colors.yellow,  // ✅ default focused color
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey)
            : null,
        suffixIcon: suffixIcon,
        suffix: suffix,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 35,
          minHeight: 35,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),

        // ✅ Borders
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
        ),
      ),
    );
  }
}
