import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dialog/dialog_languages.dart';
import 'package:teacher/screens/authentication/domain/view/login_screen.dart';
import 'package:teacher/screens/settings/change_wallpaper/change_wallpaper_screen.dart';
import 'package:teacher/screens/settings/faq/faq_screen.dart';
import 'package:teacher/screens/settings/settings_screen/bloc/setting_screen_bloc.dart';
import 'package:teacher/screens/settings/user_manual/user_manual_screen.dart';
import 'package:teacher/screens/settings/widget/show_dialog_logout.dart';
import 'package:repository/repository.dart';

import '../widget/switch_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    required this.pushNotify,
  });

  final int pushNotify;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? selectedLanguage;
  late SettingScreenBloc settingBloc;

  @override
  void initState() {
    super.initState();
    settingBloc = SettingScreenBloc(
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      authRepository: context.read<AuthRepository>(),
      userRepository: context.read<UserRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDisableNoti = widget.pushNotify == 0;

    return BlocProvider.value(
      value: settingBloc,
      child: BlocListener<SettingScreenBloc, SettingScreenState>(
        listenWhen: (previous, current) =>
            previous.logoutStatus != current.logoutStatus,
        listener: (context, state) {
          if (state.logoutStatus.isSuccess) {
            Navigator.pushAndRemoveUntil(
              mainNavKey.currentContext!,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }

          if (state.logoutStatus.isFailure) {
            Fluttertoast.showToast(
              msg: 'Vui lòng thử lại sau',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: AppColors.black,
              textColor: AppColors.white,
            );
          }
        },
        child: BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Quản lý tài khoản',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
              ),
              Flexible(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: SettingFeature(
                        text: AppStrings.turnOffNoti,
                        iconAsset: Assets.icons.bell,
                        isDisableNoti: isDisableNoti,
                        isNotiSetting: true,
                        onPressed: () {
                          settingBloc.add(TurnOffNoti(
                            pushNotify: !isDisableNoti,
                          ));
                        },
                      ),
                    ),
                    SettingFeature(
                      text: AppStrings.userManual,
                      iconAsset: Assets.icons.userManual,
                      onPressed: () {
                        context.push(const UserManualScreen());
                      },
                    ),
                    SettingFeature(
                      text: 'FAQ',
                      iconAsset: Assets.icons.faq,
                      onPressed: () {
                        context.push(const FaqScreen());
                      },
                    ),
                    SettingFeature(
                      text: AppStrings.changeWallpaper,
                      iconAsset: Assets.icons.tablet,
                      onPressed: () {
                        context.push(const ChangeWallpaperScreen());
                      },
                    ),
                    SettingFeature(
                      showDottedLine: false,
                      text: AppStrings.changeLanguage,
                      textRight: selectedLanguage ?? 'Tiếng Việt',
                      iconAsset: Assets.icons.global,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => DialogLanguages(
                            title: 'Chuyển ngôn ngữ',
                            selectedLanguage: selectedLanguage,
                            onSelectLanguage: (language) {
                              setState(() {
                                selectedLanguage = language;
                              });
                            },
                            onClosePressed: () {
                              context.pop();
                            },
                            onSavePressed: () {
                              context.pop();
                            },
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: BlocBuilder<SettingScreenBloc, SettingScreenState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              ShowDialogLogout.show(
                                context,
                                text: 'Bạn có chắc chắn muốn đăng xuất không?',
                                onLogout: () {
                                  context
                                      .read<SettingScreenBloc>()
                                      .add(SettingScreenLoggedOut());
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child:
                                        SvgPicture.asset(Assets.icons.logout),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      AppStrings.logout,
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
