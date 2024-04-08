import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/app_main_layout.dart';
import 'package:teacher/components/textfield/input_text.dart';

import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/resources/assets.gen.dart';

import 'package:teacher/src/screens/authentication/login/bloc/login_bloc.dart';
import 'package:teacher/src/utils/dialog_utils.dart';
import 'package:teacher/src/utils/extension_context.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../resources/i18n/locale_keys.g.dart';
import '../../../../../resources/resources.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginBloc = LoginBloc(
    authRepository: Injection.get<AuthRepository>(),
    userRepository: Injection.get<UserRepository>(),
  );
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController schoolDomainController = TextEditingController();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          LoadingDialog.hide(context);
          context.pushReplacement(AppMainLayout.routeName);
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
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Assets.images.login.loginBackground.provider(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height / 4,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(6),
                          backgroundColor: const Color(0xFF9C292E),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                Assets.icons.office365,
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Đăng nhập với Office 365',
                                style: AppTextStyles.semiBold14(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _loginWithiPortalAccount(context, size, () {
                            setState(() {
                              isObsecure = !isObsecure;
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(6),
                          backgroundColor: AppColors.brand500,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Đăng nhập với Iportal',
                                style: AppTextStyles.semiBold14(
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _loginWithiPortalAccount(
      BuildContext context, Size size, Function showPassword) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        builder: (ctx) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(
                //     height: size.height / 4,
                //     width: size.width / 3,
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 24),
                //     child: Image.asset(
                //       Assets
                //           .images.logoIportalTeacher.path,
                //       fit: BoxFit.contain,
                //     )),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    LocaleKeys.titleLogin.tr(),
                    style: context.listHeading.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: AppColors.brand600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Form(
                    child: Column(
                      children: [
                        TitleAndInputText(
                          hintText: "Enter your username",
                          onChanged: (val) {},
                          controller: userNameController,
                          isRequired: true,
                          label: const Text(LocaleKeys.userName).tr(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TitleAndInputText(
                          hintText: "Enter your password",
                          onChanged: (val) {},
                          controller: passwordController,
                          isPasswordFeild: true,
                          obscureText: isObsecure,
                          isRequired: true,
                          onTapVisibilityPassword: () => showPassword.call(),
                          label: const Text(LocaleKeys.password).tr(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TitleAndInputText(
                          hintText: "Enter your domain school",
                          label: const Text("Domain iPortal").tr(),
                          onChanged: (val) {},
                          controller: schoolDomainController,
                          obscureText: false,
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: size.width,
                          child: const Text(
                            LocaleKeys.forgotDomainSchool,
                            style: TextStyle(color: AppColors.grayText),
                          ).tr(),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: size.width,
                          child: InkWell(
                            onTap: () {},
                            child: const Text(
                              LocaleKeys.forgotPassword,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.blueA200,
                                  color: AppColors.blueA200),
                            ).tr(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brand500),
                              onPressed: () {
                                loginBloc.add(LoginButtonPressed(
                                    userName: userNameController.text,
                                    password: passwordController.text));
                              },
                              child: const Text(
                                LocaleKeys.signIn,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ).tr(),
                            ),
                            Container(
                              width: size.width,
                              alignment: Alignment.center,
                              child: const Text(LocaleKeys.or).tr(),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brand500),
                              child: Text(
                                "${LocaleKeys.signIn.tr()} ${LocaleKeys.qrCode.tr()}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ).tr(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        });
  }
}
