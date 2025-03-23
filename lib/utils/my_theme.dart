import 'package:finals_fe/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.purple,
        selectionColor: AppColor.lightPurple,
        selectionHandleColor: AppColor.purple,
      ),
      textTheme: GoogleFonts.montserratTextTheme().apply(
        bodyColor: AppColor.white,
      ),
      fontFamily: GoogleFonts.montserrat().fontFamily,
      scaffoldBackgroundColor: AppColor.darkBackground,
      primaryColor: AppColor.darkBackground,
    );
  }
}
