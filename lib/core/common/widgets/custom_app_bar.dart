import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class CustomAppBar {
  static PreferredSizeWidget build() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Icon(
        Icons.grass,
        color: AppColors.greenColor,
        size: 28,
      ),
      title: Text(
        "Leaf Scan",
        style: GoogleFonts.workSans(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      titleSpacing: 0,
    );
  }
}
