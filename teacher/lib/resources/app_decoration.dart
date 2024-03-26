import 'package:flutter/material.dart';
import 'package:teacher/resources/app_colors.dart';
import 'package:teacher/resources/app_size.dart';

class AppDecoration {
  static BoxDecoration get fillGray100 =>
      const BoxDecoration(color: AppColors.gray100);
}

class AppRadius {
  static BorderRadius get rounded10 => BorderRadius.circular(10.h);

  static BorderRadius get rounded14 => BorderRadius.circular(14.h);

  static BorderRadius get rounded20 => BorderRadius.circular(20.h);

  static BorderRadius get rounded24 => BorderRadius.circular(24.h);

  static BorderRadius get roundedBottom8 => BorderRadius.vertical(
        bottom: Radius.circular(8.h),
      );

  static BorderRadius get roundedBottom12 => BorderRadius.vertical(
        bottom: Radius.circular(12.h),
      );
  static BorderRadius get roundedTop12 => BorderRadius.vertical(
        top: Radius.circular(12.h),
      );
  static BorderRadius get roundedTop6 => BorderRadius.vertical(
        top: Radius.circular(6.h),
      );
  static BorderRadius get roundedTop16 => BorderRadius.vertical(
        top: Radius.circular(16.h),
      );

  static BorderRadius get roundedTop20 => BorderRadius.vertical(
        top: Radius.circular(20.h),
      );

  static BorderRadius get roundedTop28 => BorderRadius.vertical(
        top: Radius.circular(28.h),
      );
}
