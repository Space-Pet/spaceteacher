import 'package:flutter/material.dart';
import 'package:iportal2/components/textfield/input_text.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';

class DialogChangePassword extends StatefulWidget {
  const DialogChangePassword({super.key, 
    this.onSavePressed,
    this.onClosePressed,
  });
  final Function()? onSavePressed;
  final Function()? onClosePressed;

  @override
  State<DialogChangePassword> createState() => _DialogChangePasswordState();
}

class _DialogChangePasswordState extends State<DialogChangePassword> {
  bool _isInputFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _isInputFocused = false;
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
                Text(
                  'Đổi mật khẩu',
                  style: AppTextStyles.normal18(fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: TitleAndInputText(
                    hintText: 'Nhập mật khẩu cũ',
                    onChanged: (value) {},
                    prefixIcon: Assets.icons.lock.image(),
                    onTap: () {
                      setState(() {
                        _isInputFocused = true;
                      });
                    },
                    onEditComplated: () {
                      setState(() {
                        _isInputFocused = false;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                  ),
                ),
                TitleAndInputText(
                  hintText: 'Nhập mật khẩu mới',
                  onChanged: (value) {},
                  prefixIcon: Assets.icons.lock.image(),
                  onTap: () {
                    setState(() {
                      _isInputFocused = true;
                    });
                  },
                  onEditComplated: () {
                    setState(() {
                      _isInputFocused = false;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: TitleAndInputText(
                    hintText: 'Nhập lại mật khẩu mới',
                    onChanged: (value) {},
                    prefixIcon: Assets.icons.lock.image(),
                    obscureText: true,
                    onTap: () {
                      setState(() {
                        _isInputFocused = true;
                      });
                    },
                    onEditComplated: () {
                      setState(() {
                        _isInputFocused = false;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: !_isInputFocused,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: widget.onSavePressed ?? () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redMenu,
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Cập nhật',
                            style: TextStyle(color: AppColors.whiteBackground),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color?>(
                            AppColors.white,
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(color: AppColors.gray300),
                          ),
                        ),
                        onPressed: widget.onClosePressed ??
                            () => Navigator.pop(context),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Đóng',
                            style: TextStyle(color: AppColors.black),
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
  }
}
