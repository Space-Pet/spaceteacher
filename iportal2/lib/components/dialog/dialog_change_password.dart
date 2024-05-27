import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iportal2/components/textfield/input_text.dart';
import 'package:iportal2/resources/assets.gen.dart';

class DialogChangePassword {
  static Future<void> show(
    BuildContext context, {
    required Function(String currentPassword, String newPassword, String confirmPassword) onSavePressed,
    required Function() onClosePressed,
  }) async {
    Completer<void> completer = Completer<void>();

    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    bool isInputFocused = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                setState(() {
                  isInputFocused = false;
                });
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                surfaceTintColor: Colors.transparent,
                content: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const Text(
                          'Đổi mật khẩu',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TitleAndInputText(
                            onChanged: (value) {},
                            hintText: 'Nhập mật khẩu cũ',
                            controller: currentPasswordController,
                            prefixIcon: Assets.icons.lock.image(),
                            onTap: () {
                              setState(() {
                                isInputFocused = true;
                              });
                            },
                            onEditComplated: () {
                              setState(() {
                                isInputFocused = false;
                                FocusScope.of(context).requestFocus(FocusNode());
                              });
                            },
                          ),
                        ),
                        TitleAndInputText(
                          onChanged: (value) {},
                          hintText: 'Nhập mật khẩu mới',
                          controller: newPasswordController,
                          prefixIcon: Assets.icons.lock.image(),
                          onTap: () {
                            setState(() {
                              isInputFocused = true;
                            });
                          },
                          onEditComplated: () {
                            setState(() {
                              isInputFocused = false;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TitleAndInputText(
                            onChanged: (value) {},
                            hintText: 'Nhập lại mật khẩu mới',
                            controller: confirmPasswordController,
                            prefixIcon: Assets.icons.lock.image(),
                            onTap: () {
                              setState(() {
                                isInputFocused = true;
                              });
                            },
                            onEditComplated: () {
                              setState(() {
                                isInputFocused = false;
                                FocusScope.of(context).requestFocus(FocusNode());
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: !isInputFocused,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  onSavePressed(
                                    currentPasswordController.text,
                                    newPasswordController.text,
                                    confirmPasswordController.text,
                                  );
                                  Navigator.pop(context);
                                  completer.complete();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Cập nhật',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color?>(
                                    Colors.white,
                                  ),
                                  side: MaterialStateProperty.all<BorderSide>(
                                    const BorderSide(color: Colors.grey),
                                  ),
                                ),
                                onPressed: () {
                                  onClosePressed();
                                  Navigator.pop(context);
                                  completer.complete();
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Đóng',
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    return completer.future;
  }
}
