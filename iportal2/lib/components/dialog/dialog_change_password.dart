import 'package:core/core.dart' hide TitleAndInputText;
import 'package:flutter/material.dart';
import 'package:iportal2/components/textfield/input_text.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/settings/settings_screen/bloc/setting_screen_bloc.dart';

class DialogChangePassword extends StatefulWidget {
  const DialogChangePassword({
    super.key,
    required this.bloc,
  });

  final SettingScreenBloc bloc;

  @override
  State<DialogChangePassword> createState() => _DialogChangePasswordState();
}

class _DialogChangePasswordState extends State<DialogChangePassword> {
  TextEditingController currentPassword = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController passwordConfirmation = TextEditingController(text: '');
  final FocusNode _focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = currentPassword.text.isNotEmpty &&
        password.text.isNotEmpty &&
        passwordConfirmation.text.isNotEmpty;

    return BlocProvider.value(
      value: widget.bloc,
      child: BlocConsumer<SettingScreenBloc, SettingScreenState>(
        listener: (context, state) {
          if (state.logoutStatus.isSuccessChangePassword) {
            Navigator.pop(context);
            SnackBarUtils.showFloatingSnackBar(
                context, 'Đổi mật khẩu thành công!');
          }
        },
        builder: (context, state) {
          final errMsg = state.message;

          return Container(
            width: 320.h,
            decoration: ShapeDecoration(
              color: AppColors.blueGray25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Đổi mật khẩu',
                  style: AppTextStyles.semiBold18(color: AppColors.gray900),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TitleAndInputText(
                    onChanged: (value) {
                      setState(() {
                        currentPassword.text = value;
                      });
                    },
                    isValid: !state.logoutStatus.isFailureChangePassword,
                    obscureText: true,
                    focusNode: _focusNode,
                    hintText: 'Nhập mật khẩu cũ',
                    controller: currentPassword,
                    prefixIcon: Assets.icons.lock.image(),
                    onTap: () {},
                    onEditComplated: () {},
                  ),
                ),
                TitleAndInputText(
                  onChanged: (value) {
                    setState(() {
                      password.text = value;
                    });
                  },
                  isValid: !state.logoutStatus.isFailureChangePassword,
                  hintText: 'Nhập mật khẩu mới',
                  obscureText: true,
                  controller: password,
                  prefixIcon: Assets.icons.lock.image(),
                  onTap: () {},
                  onEditComplated: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TitleAndInputText(
                    onChanged: (value) {
                      setState(() {
                        passwordConfirmation.text = value;
                      });
                    },
                    hintText: 'Nhập lại mật khẩu mới',
                    isValid: !state.logoutStatus.isFailureChangePassword,
                    obscureText: true,
                    controller: passwordConfirmation,
                    prefixIcon: Assets.icons.lock.image(),
                    onTap: () {},
                    onEditComplated: () {},
                  ),
                ),
                if ((errMsg ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      errMsg ?? '',
                      style: AppTextStyles.normal14(color: AppColors.redMenu),
                    ),
                  ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 6),
                      child: ElevatedButton(
                        onPressed: () {
                          if (canSubmit) {
                            widget.bloc.add(
                              ChangePassword(
                                currentPassword: currentPassword.text,
                                password: password.text,
                                passwordConfirmation: passwordConfirmation.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              canSubmit ? AppColors.redMenu : AppColors.gray100,
                        ),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Lưu lại',
                              style: AppTextStyles.semiBold16(
                                  color: AppColors.white),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color?>(AppColors.white),
                        side: WidgetStateProperty.all<BorderSide>(
                          const BorderSide(color: AppColors.gray300),
                        ),
                      ),
                      onPressed: () {
                        currentPassword.clear();
                        password.clear();
                        passwordConfirmation.clear();
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            style: AppTextStyles.semiBold16(
                                color: AppColors.gray900),
                            'Hủy',
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
