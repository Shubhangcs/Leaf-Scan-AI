import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final bool isObscure;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscure;

  @override
  void initState() {
    isObscure = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
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
        suffixIcon:widget.isObscure? IconButton(
          onPressed: () {
           setState(() {
              isObscure = !isObscure;
           });
          },
          icon: Icon(
            Icons.remove_red_eye_outlined,
          ),
        ): null,
      ),
    );
  }
}
