import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_expense_tracker/config/config.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => FlexThemeData.light(
        scheme: FlexScheme.custom,
        colors: FlexSchemeColor.from(primary: AppColors.primary),
        useMaterial3: true,
        primaryTextTheme: GoogleFonts.interTextTheme(),
        textTheme: GoogleFonts.interTextTheme(),
      );
  static ThemeData get darkTheme => FlexThemeData.dark(
        scheme: FlexScheme.custom,
        colors: FlexSchemeColor.from(primary: AppColors.primary),
        useMaterial3: true,
        primaryTextTheme: GoogleFonts.interTextTheme(),
        textTheme: GoogleFonts.interTextTheme(),
      );
}
