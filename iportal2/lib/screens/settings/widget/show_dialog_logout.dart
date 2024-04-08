import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ShowDialogLogout {
  static Future<void> show(BuildContext context,
      {Widget? child,
      required String title,
      Function()? onTap,
      Function()? onTapConfirm,
      required String textConten}) async {
    Completer<void> completer = Completer<void>();
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                if (child != null) child!,
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.normal18(
                        fontWeight: FontWeight.w600, height: 0.09),
                  ),
                ),
              ],
            ),
            surfaceTintColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    textConten,
                    style: AppTextStyles.normal14(color: AppColors.gray500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(AppColors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: AppColors.gray400),
                        ),
                      ),
                      onPressed: onTap ?? () => Navigator.pop(context),
                      child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            style: TextStyle(color: AppColors.black),
                            'Đóng',
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                  if (onTapConfirm != null)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(AppColors.red900),
                      ),
                      onPressed: onTapConfirm ?? () => Navigator.pop(context),
                      child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            style: TextStyle(color: AppColors.white),
                            'Đồng ý',
                            textAlign: TextAlign.center,
                          )),
                    ),
                ],
              ),
            ),
          );
        });
    return completer.future;
  }
}
