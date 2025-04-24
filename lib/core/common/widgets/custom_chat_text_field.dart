import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class CustomChatTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final VoidCallback? suffixOnPressed;
  final FocusNode? focusNode;
  const CustomChatTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.suffixOnPressed,
    this.focusNode,
  });

  @override
  State<CustomChatTextField> createState() => _CustomChatTextFieldState();
}

class _CustomChatTextFieldState extends State<CustomChatTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autocorrect: true,
      cursorColor: AppColors.greenColor,
      cursorErrorColor: AppColors.greenColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        icon: widget.icon,
        hintStyle: GoogleFonts.workSans(
          color: AppColors.darkGreyColor,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: IconButton(
          onPressed: widget.suffixOnPressed,
          icon: Icon(
            Icons.send_rounded,
            color: AppColors.greenColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}