import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iportal2/components/input_text.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';

class CustomDialogUpdatePhone {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String saveButtonTitle,
    required String closeButtonTitle,
    Function(String phone)? onSavePressed,
  }) async {
    Completer<void> completer = Completer<void>();
    await showDialog(
        context: context,
        builder: (context) {
          double screenWidth = MediaQuery.of(context).size.width;
          String phone = '';
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              textAlign: TextAlign.center,
              title,
              style: AppTextStyles.semiBold18(),
            ),
            surfaceTintColor: Colors.transparent,
            content: SizedBox(
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleAndInputText(
                      textInputType: false,
                      title: '',
                      hintText: 'Nhập số điện thoại mới',
                      onChanged: (value) {
                        phone = value;
                      },
                      prefixIcon: Assets.icons.phone.image(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 6),
                      child: ElevatedButton(
                        onPressed: onSavePressed != null
                            ? () {
                                onSavePressed(phone);
                                Navigator.pop(
                                    context); 
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redMenu),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              saveButtonTitle,
                              style: const TextStyle(
                                  color: AppColors.whiteBackground),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(AppColors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: AppColors.gray300),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            style: const TextStyle(color: AppColors.black),
                            closeButtonTitle,
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
