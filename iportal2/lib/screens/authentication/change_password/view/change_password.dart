import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/authentication/change_password/bloc/change_password_bloc.dart';
import 'package:iportal2/screens/authentication/domain/domain_screen.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:repository/repository.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/changePassword';
  const ChangePasswordScreen(
      {super.key, required this.numberPhone, required this.type});
  final String numberPhone;
  final String type;
  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    return BlocProvider(
      create: (context) => ChangePasswordBloc(authRepository: authRepository),
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listenWhen: (previous, current) {
          return previous.changePasswordStatus != current.changePasswordStatus;
        },
        listener: (context, state) {
          if (state.changePasswordStatus == ChangePasswordStatus.loading) {
            LoadingDialog.show(context);
          } else if (state.changePasswordStatus == ChangePasswordStatus.error) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          } else if (state.changePasswordStatus ==
              ChangePasswordStatus.success) {
            LoadingDialog.hide(context);
            context.pushReplacement(const DomainScreen());
            Fluttertoast.showToast(
                msg: 'Đổi mật khẩu thành công',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.green,
                textColor: AppColors.white);
          }
        },
        child: ChangePasswordView(
          type: type,
          numberPhone: numberPhone,
        ),
      ),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView(
      {super.key, required this.numberPhone, required this.type});
  final String numberPhone;
  final String type;
  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
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
                          hintText: 'Mật khẩu mới',
                          prefixIcon: Assets.icons.lock.image(),
                          onChanged: (value) {
                            password.text = value;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TitleAndInputText(
                          hintText: 'Xác nhận mật khẩu',
                          prefixIcon: Assets.icons.lock.image(),
                          onChanged: (value) {
                            passwordConfirmation.text = value;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: GestureDetector(
                        onTap: () {
                          context.read<ChangePasswordBloc>().add(ChangePassword(
                              numberPhone: widget.numberPhone,
                              password: password.text,
                              passwordConfirmation: passwordConfirmation.text,
                              type: widget.type));
                        },
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
                            child:  const Padding(
                              padding: EdgeInsets.only(top: 17, bottom: 17),
                              child: Text(
                                'Xác nhận',
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
