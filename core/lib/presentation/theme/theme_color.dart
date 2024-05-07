import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import '../../src/src.dart';



ThemeColor get themeColor => Injection.get<ThemeColor>();

abstract class ThemeColor {
  /// iportal App
  final white = Colors.white;
  final transparent = Colors.transparent;

  Color get primaryColor;

  Color get primaryColorLight;

  final cardBackground = const Color(0xFFf7f8f8);

  final lightGrey = const Color(0xFFbebebe);
  final black = const Color(0xFF000000);
  final greyE5 = const Color(0xFFE5E5E5);

  //HEX code color
  final colorF3F3F3 = const Color(0xFFF3F3F3);
  final colorF0F0F5 = const Color(0xFFF0F0F5);
  final colorE6E6EB = const Color(0xFFE6E6EB);
  final color8D8D94 = const Color(0xFF8D8D94);
  final colorEE1602 = const Color(0xFFEE1602);
  final colorFF9A05 = const Color(0xFFFF9A05);
  final color165CA0 = const Color(0xFF165CA0);
  final color0D8330 = const Color(0xFF0D8330);

  Color get activeColor => primaryColor;

  final green = const Color(0xFF4d9e53);
  final red = const Color(0xFFfb4b53);
  final darkBlue = const Color(0xFF002d41);

  //light
  Color get primaryText => const Color(0xFF272727);
  final subText = const Color(0xFF767676);

  final linkText = const Color(0xFF3680D8);

  //dart
  final primaryDarkText = Colors.black;
  final subDarkText = Colors.grey;

  final grayF6F7FB = const Color(0xFFF6F7FB);
  final grayAD = const Color(0xFFADADAD);

  Color get greyTextColor => const Color(0xFF8C8C8C);
  Color get errorTextColor => const Color(0xFFEC3237);

  void setLightStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }

  void setDarkStatusBar() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }
}
