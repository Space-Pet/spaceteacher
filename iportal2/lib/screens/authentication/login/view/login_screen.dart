import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_strings.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/app_main_layout.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/input_text.dart';
import 'package:iportal2/screens/authentication/forgot_password/view/forgot_password_screen.dart';
import 'package:iportal2/screens/authentication/login_qr/login_qr.dart';
import 'package:iportal2/screens/authentication/utilites/dialog_utils.dart';
import 'package:repository/repository.dart';

import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final currentUserBloc = context.read<CurrentUserBloc>();

    return BlocProvider(
      create: (context) => LoginBloc(
        context: context,
        authRepository: authRepository,
        currentUserBloc: currentUserBloc,
        userRepository: context.read<UserRepository>(),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            LoadingDialog.hide(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AppMainLayout(),
              ),
            );
          } else if (state.status == LoginStatus.emptyLoginInfoError) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: 'Hãy nhập tài khoản để đăng nhập',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          } else if (state.status == LoginStatus.failure) {
            Fluttertoast.showToast(
                msg: 'Tài khoản không hợp lệ',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
            LoadingDialog.hide(context);
          } else if (state.status == LoginStatus.init ||
              state.status == LoginStatus.loading) {
            LoadingDialog.show(context);
          }
        },
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final loginBloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
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
                      image: Assets.images.login.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 8, right: 12),
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
                        top: 6, bottom: 24, left: 14, right: 14),
                    height: screenHeight / 1.70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 4),
                          child: Text(
                            AppStrings.titleLogin,
                            style: AppTextStyles.bold16(
                              color: AppColors.textTitleLogin,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: TitleAndInputText(
                              title: 'title',
                              hintText: AppStrings.account,
                              prefixIcon: Assets.icons.user.image(),
                              onChanged: (value) {
                                loginBloc.add(LoginUsernameChanged(value));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: TitleAndInputText(
                              title: 'title',
                              hintText: AppStrings.password,
                              prefixIcon: Assets.icons.lock.image(),
                              onChanged: (value) {
                                loginBloc.add(LoginPasswordChanged(value));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push(const ForgotPasswordScreen());
                                },
                                child: Text(
                                  AppStrings.forgetPassword,
                                  style: AppTextStyles.custom(
                                    fontSize: 14,
                                    color: AppColors.textTitleLogin,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            onTap: () {
                              loginBloc.add(LoginSubmitted());
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
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 16),
                                  child: Text(
                                    AppStrings.login,
                                    style: AppTextStyles.semiBold16(
                                      color: AppColors.white,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: const Divider(
                                    color: AppColors.gray300,
                                    height: 36,
                                  )),
                            ),
                            Text(
                              AppStrings.or,
                              style: AppTextStyles.normal14(
                                  color: AppColors.gray400),
                            ),
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: const Divider(
                                    color: AppColors.gray300,
                                    height: 36,
                                  )),
                            ),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(const LoginQRScreen());
                          },
                          child: Container(
                            width: double.infinity,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF8F8FB),
                              shape: RoundedRectangleBorder(
                                side:
                                    const BorderSide(color: Color(0xFFEAECF0)),
                                borderRadius: BorderRadius.circular(60),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/icons/qrcode.png'),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        AppStrings.qrCode,
                                        style: AppTextStyles.semiBold14(
                                          color: AppColors.gray800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            'iPortal version 1.0.0 (37) - 20240220',
                            style: AppTextStyles.normal12(
                              color: AppColors.gray400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
