import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:teacher/app_main_layout.dart';

import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';
import 'package:teacher/resources/assets.gen.dart';

import 'package:teacher/src/screens/authentication/login/bloc/login_bloc.dart';
import 'package:teacher/src/utils/dialog_utils.dart';
import 'package:teacher/src/utils/extension_context.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  LoginScreen({super.key});
  final loginBloc = LoginBloc(
    authRepository: Injection.get<AuthRepository>(),
    userRepository: Injection.get<UserRepository>(),
    domainSaver: Injection.get<DomainSaver>(),
  );

  TextStyle get hintStyle => TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[500]);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          LoadingDialog.hide(context);
          context.pushReplacement(AppMainLayout.routeName);
        } else if (state.status == LoginStatus.failure) {
          Fluttertoast.showToast(
              msg: 'Tài khoản không hợp lệ',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.black,
              textColor: AppColors.white);
          LoadingDialog.hide(context);
        } else if (state.status == LoginStatus.loading) {
          LoadingDialog.show(context);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: Stack(
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
                    height: size.height / 2.8,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                'Nhập đường dẫn',
                                style: AppTextStyles.normal16(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.brand600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 18,
                                left: 10,
                                right: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColors.gray300)),
                                child: TextField(
                                  onChanged: (value) {
                                    loginBloc
                                        .add(LoginDomainSave(domain: value));
                                  },
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(8),
                                    filled: true,
                                    fillColor: AppColors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.white,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintStyle: state.cachedDomain.isEmpty
                                        ? hintStyle
                                        : hintStyle.copyWith(
                                            color: AppColors.black),
                                    hintText: state.cachedDomain.isEmpty
                                        ? 'Nhập đường dẫn website iPortal của đơn vị'
                                        : state.cachedDomain,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 8, left: 10, right: 10),
                              child: Text(
                                textAlign: TextAlign.start,
                                'Vui lòng liên hện IT trường nếu như bạn quên đường dẫn website iPortal',
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (state.isReadyToSubmit) {
                                      loginBloc.add(LoginWith365());
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Hãy nhập đường dẫn website iPortal',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: AppColors.black,
                                          textColor: AppColors.white);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(6),
                                    backgroundColor: state.isReadyToSubmit
                                        ? const Color(0xFF9C292E)
                                        : Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Assets.icons.office365.svg(
                                          width: 24,
                                          height: 24,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.white, BlendMode.srcIn),
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
                            ),
                          ],
                        ),
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
