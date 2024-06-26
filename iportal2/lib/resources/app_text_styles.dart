import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_size.dart';

class AppTextStyles {
  static TextStyle custom({
    Color color = AppColors.blueGray800,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 12,
    Color? backgroundColor,
    FontStyle? fontStyle,
    double? height,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        color: color,
        backgroundColor: backgroundColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
      );

  static TextStyle titlePage({Color color = AppColors.white}) =>
      GoogleFonts.inter(
        color: color,
        fontSize: 24.fSize,
        fontWeight: FontWeight.w800,
      );

  // 12
  static TextStyle normal12({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.inter(
        color: color,
        fontSize: 12.fSize,
        fontWeight: fontWeight,
        height: height,
      );

  static TextStyle semiBold12({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal12(fontWeight: FontWeight.w600, color: color, height: height);

  static TextStyle bold12({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal12(fontWeight: FontWeight.w700, color: color, height: height);

// 14
  static TextStyle normal14({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.inter(
        color: color,
        fontSize: 14.fSize,
        fontWeight: fontWeight,
        height: height,
      );

  static TextStyle semiBold14({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal14(fontWeight: FontWeight.w600, color: color, height: height);

  static TextStyle bold14({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal14(fontWeight: FontWeight.w700, color: color, height: height);

  // 16
  static TextStyle normal16({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.inter(
        color: color,
        fontSize: 16.fSize,
        fontWeight: fontWeight,
        height: height,
      );

  static TextStyle semiBold16({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal16(fontWeight: FontWeight.w600, color: color, height: height);

  static TextStyle bold16({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal16(fontWeight: FontWeight.w700, color: color, height: height);

  // 18
  static TextStyle normal18({
    Color color = AppColors.black,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.inter(
        color: color,
        fontSize: 18.fSize,
        fontWeight: fontWeight,
        height: height,
      );

  static TextStyle semiBold18({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal18(fontWeight: FontWeight.w600, color: color, height: height);

  static TextStyle bold18({
    Color color = AppColors.black,
    double? height,
  }) =>
      normal18(fontWeight: FontWeight.w700, color: color, height: height);
}
