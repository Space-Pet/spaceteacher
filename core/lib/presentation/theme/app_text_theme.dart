import 'package:flutter/material.dart';

import 'theme_color.dart';

class AppTextTheme {
  static TextStyle textLinkStyle = TextStyle(
    decoration: TextDecoration.underline,
    color: themeColor.linkText,
    fontSize: 14,
  );

  static TextTheme getDefaultTextTheme() => TextTheme(
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headline4: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headline5: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        headline6: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: themeColor.subText,
        ),
        subtitle1: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        subtitle2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: themeColor.subText,
        ),
        bodyText1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryText,
        ),
        caption: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryText,
        ),
        button: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );

  static TextTheme getDefaultTextThemeDark() => TextTheme(
        headline3: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryColor,
        ),
        headline4: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        headline5: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        headline6: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        subtitle1: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: themeColor.subDarkText,
        ),
        subtitle2: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: themeColor.subDarkText,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: themeColor.primaryDarkText,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryDarkText,
        ),
        caption: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: themeColor.primaryDarkText,
        ),
        button: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: themeColor.primaryDarkText,
        ),
      );
}
