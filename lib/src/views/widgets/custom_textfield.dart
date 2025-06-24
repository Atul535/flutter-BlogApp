import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? validationText;
  final bool? isObscure;
  final bool? isColored;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  const CustomTextfield({
    super.key,
    this.hintText,
    this.validationText,
    this.helperText,
    this.isObscure,
    this.labelText,
    this.prefixIcon,
    this.controller,
    this.isColored,
    this.maxLines,
    this.color,
    this.style,
    this.hintStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      obscureText: isObscure ?? false,
      maxLines: maxLines ?? 1,
      style: style,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return validationText;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: color,
        filled: isColored,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        helperText: helperText,
        disabledBorder: InputBorder.none,
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          color: const Color.fromARGB(255, 3, 47, 84),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide:
              const BorderSide(color: Colors.white), // Added border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide: const BorderSide(
              color: Colors.white, width: 2), // Thicker white border on focus
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide: const BorderSide(
              color: Colors.red, width: 2), // Thicker white border on focus
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.sp),
          borderSide: const BorderSide(
              color: Colors.red, width: 2), // Thicker white border on focus
        ),
      ),
    );
  }
}
