import 'package:flutter/material.dart';

import 'theme_color.dart';

class AppTextTheme {
  static TextStyle textLinkStyle = TextStyle(
    decoration: TextDecoration.underline,
    color: themeColor.linkText,
    fontSize: 14,
  );

  static TextTheme getDefaultTextTheme() => TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        titleLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: themeColor.subText,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryText,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        labelLarge: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

  static TextTheme getDefaultTextThemeDark() => TextTheme(
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: themeColor.subDarkText,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: themeColor.subDarkText,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryDarkText,
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryDarkText,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryDarkText,
        ),
      );
}
