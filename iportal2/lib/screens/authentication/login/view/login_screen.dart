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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 14, right: 14),
                    height: screenHeight / 1.61,
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
                          padding: EdgeInsets.only(top: 20, bottom: 15),
                          child: Text(
                            AppStrings.titleLogin,
                            style: TextStyle(
                              color: AppColors.textTitleLogin,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.09,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
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
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push(const ForgotPasswordScreen());
                                },
                                child: const Text(
                                  AppStrings.forgetPassword,
                                  style: TextStyle(
                                    color: AppColors.textTitleLogin,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
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
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 17, bottom: 17),
                                  child: Text(
                                    AppStrings.login,
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
                            const Text(
                              AppStrings.or,
                              style: TextStyle(color: AppColors.gray400),
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
                        Container(
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF8F8FB),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFFEAECF0)),
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
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      AppStrings.qrCode,
                                      style: TextStyle(
                                        color: Color(0xFF1D2838),
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            'iPortal version 1.0.0 (3) - 20240220',
                            style: TextStyle(
                              color: Color(0xFF98A1B2),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
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
