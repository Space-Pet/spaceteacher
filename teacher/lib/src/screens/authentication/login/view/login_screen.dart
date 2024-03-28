import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/components/textfield/input_text.dart';
import 'package:teacher/components/toggle_lang/toogle_lang.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';

import 'package:teacher/src/screens/authentication/login/bloc/login_bloc.dart';
import 'package:teacher/src/screens/home/view/home_screen.dart';
import 'package:teacher/src/utils/dialog_utils.dart';
import 'package:teacher/src/utils/extension_context.dart';
import 'package:easy_localization/easy_localization.dart';

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
          context.pushReplacement(HomeScreen.routeName);
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
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: size.height / 3,
                width: size.width / 2,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Placeholder(),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(
                  "title_login",
                  style: context.listHeading.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ).tr(),
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
                        label: const Text("user_name").tr(),
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
                        onTapVisibilityPassword: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        label: const Text("password").tr(),
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
                        child: const Text("forgot_domain_school").tr(),
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
                            "forgot_password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.blueA200,
                                color: AppColors.blueA200),
                          ).tr(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              loginBloc.add(LoginButtonPressed(
                                  userName: userNameController.text,
                                  password: passwordController.text));
                            },
                            child: const Text(
                              "sign_in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr(),
                          ),
                          Container(
                            width: size.width,
                            alignment: Alignment.center,
                            child: const Text("or").tr(),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "${"sign_in".tr()} ${"qr_code".tr()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const ToggleLang(),
            ],
          ),
        );
      },
    );
  }
}
