import 'package:flutter/material.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class CustomSnackBar {
  final String message;
  CustomSnackBar({required this.message});

  SnackBar build(BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: AppColors.whiteColor),
      ),
      backgroundColor: AppColors.greenColor,
      elevation: 1,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
