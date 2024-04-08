import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_strings.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/app_main_layout.dart';
import 'package:iportal2/screens/authentication/forgot_password/view/forgot_password_screen.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:iportal2/components/input_text.dart';
import 'package:repository/repository.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/changePassword';
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChangePasswordView();
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.forgot.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 34,
                    color: AppColors.white,
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 14, right: 14),
                height: screenHeight / 1.80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 15),
                      child: Column(
                        children: [
                          Text(
                            'Đặt lại mật khẩu',
                            style: TextStyle(
                              color: AppColors.textTitleLogin,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.09,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text(
                        'Tài khoản của bạn đã được xác thực.',
                        style: TextStyle(
                          color: AppColors.gray600,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          height: 0.09,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text(
                        'Vui lòng đặt lại mật khẩu.',
                        style: TextStyle(
                          color: AppColors.gray600,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          height: 0.09,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TitleAndInputText(
                          title: 'title',
                          hintText: 'Mật khẩu mới',
                          prefixIcon: Assets.icons.lock.image(),
                          onChanged: (value) {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TitleAndInputText(
                          title: 'title',
                          hintText: 'Xác nhận mật khẩu',
                          prefixIcon: Assets.icons.lock.image(),
                          onChanged: (value) {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: AppColors.primaryRedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 17, bottom: 17),
                              child: Text(
                                AppStrings.confirm,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
