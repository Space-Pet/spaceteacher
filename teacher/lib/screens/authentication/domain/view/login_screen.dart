import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/authentication/domain/view/choose_school.dart';

import '../../../../app_main_layout.dart';
import '../../../../resources/assets.gen.dart';
import '../../utilites/dialog_utils.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle get hintStyle => TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey[500]);

  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(
      authRepository: Injection.get<AuthRepository>(),
      domainSaver: Injection.get<DomainSaver>(),
      userRepository: Injection.get<UserRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        final loginStatus = state.status;
        switch (loginStatus) {
          case LoginStatus.success:
            LoadingDialog.hide(context);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AppMainLayout()),
            );
            break;
          case LoginStatus.failure:
            Fluttertoast.showToast(
              msg: 'Tài khoản không hợp lệ',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.black,
              textColor: AppColors.white,
            );
            LoadingDialog.hide(context);
            break;
          case LoginStatus.loading:
            LoadingDialog.show(context);
            break;
          case LoginStatus.chooseSchool:
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              isDismissible: false,
              builder: (BuildContext context) =>
                  TeacherChooseSchool(loginBloc: loginBloc),
            );
            break;

          default:
            // LoadingDialog.hide(context);
            break;
        }
      },
      builder: (context, state) {
        final isReadyToSubmit = state.isReadyToSubmit;
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                loginBloc.add(const LoginDomainSave(
                                    domain: 'test-iportal.nhg.vn'));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    'Nhập đường dẫn',
                                    style: AppTextStyles.normal16(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.brand600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                left: 10,
                                right: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: state.showError
                                          ? AppColors.red
                                          : isReadyToSubmit
                                              ? AppColors.green600
                                              : AppColors.gray300,
                                    )),
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
                            if (state.showError || isReadyToSubmit)
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 6, 10, 0),
                                child: Text(
                                    isReadyToSubmit
                                        ? 'Đường dẫn hợp lệ, đăng nhập ngay!'
                                        : 'Đường dẫn không tồn tại trong hệ thống!',
                                    style: AppTextStyles.semiBold14(
                                      color: isReadyToSubmit
                                          ? AppColors.green600
                                          : AppColors.red900,
                                    )),
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 10, 0),
                              child: Text(
                                  'Vui lòng liên hện IT trường nếu như bạn quên đường dẫn website iPortal',
                                  style: AppTextStyles.normal12()),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (state.isReadyToSubmit) {
                                loginBloc.add(LoginWith365());
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Hãy nhập đường dẫn website iPortal',
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
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
