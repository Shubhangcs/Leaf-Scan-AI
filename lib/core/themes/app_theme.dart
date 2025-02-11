import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class AppTheme {
  static _borderStyle([Color color = AppColors.darkGreyColor , double width = 1]) {
    return UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: width,
        )
      );
  }

  static final ThemeData applicationTheme =
      ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      surfaceTintColor: AppColors.whiteColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor,
        systemNavigationBarColor: AppColors.whiteColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.greenColor,
      enabledBorder: _borderStyle(),
      border: _borderStyle(),
      disabledBorder: _borderStyle(),
      errorBorder: _borderStyle(),
      focusedBorder: _borderStyle(AppColors.greenColor , 2),
    ),
  );
}
