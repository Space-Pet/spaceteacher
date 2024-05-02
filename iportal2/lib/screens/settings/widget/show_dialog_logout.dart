import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ShowDialogLogout {
  static Future<void> show(
    BuildContext context, {
    required String text,
    required Function() onLogout,
  }) async {
    Completer<void> completer = Completer<void>();
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.normal18(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            surfaceTintColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(AppColors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: AppColors.gray400),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            style: TextStyle(color: AppColors.black),
                            'Hủy',
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(AppColors.red900),
                    ),
                    onPressed: onLogout,
                    child: const SizedBox(
                        width: double.infinity,
                        child: Text(
                          style: TextStyle(color: AppColors.white),
                          'Đăng xuất',
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
