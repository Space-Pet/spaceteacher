import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/dialog/dialog_change_password.dart';
import 'package:iportal2/components/dialog/dialog_languages.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_strings.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/authentication/login/view/login_screen.dart';
import 'package:iportal2/screens/settings/change_account_screen/change_account.dart';
import 'package:iportal2/screens/settings/change_wallpaper/change_wallpaper_screen.dart';
import 'package:iportal2/screens/settings/settings_screen/bloc/setting_screen_bloc.dart';
import 'package:repository/repository.dart';

import '../widget/switch_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingScreenBloc(
        authRepository: context.read<AuthRepository>(),
        userRepository: context.read<UserRepository>(),
      ),
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
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: SwitchSetting(
                          text: AppStrings.turnOffNoti,
                          iconAsset: Assets.icons.bell,
                          showDottedLine: true,
                        ),
                      ),
                      SwitchSetting(
                        text: AppStrings.feedback,
                        iconAsset: Assets.icons.message,
                        showDottedLine: true,
                        onPressed: () {},
                      ),
                      SwitchSetting(
                        showDottedLine: true,
                        text: AppStrings.userManual,
                        iconAsset: Assets.icons.userManual,
                        onPressed: () {},
                      ),
                      SwitchSetting(
                        showDottedLine: true,
                        text: AppStrings.changeAccount,
                        iconAsset: Assets.icons.accountConversion,
                        onPressed: () {
                          context.push(const ChangeAccountScreen());
                        },
                      ),
                      SwitchSetting(
                        showDottedLine: true,
                        text: AppStrings.changePassword,
                        iconAsset: Assets.icons.message,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogChangePassword(
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
                      SwitchSetting(
                        showDottedLine: true,
                        text: AppStrings.changeWallpaper,
                        iconAsset: Assets.icons.tablet,
                        onPressed: () {
                          context.push(const ChangeWallpaperScreen());
                        },
                      ),
                      SwitchSetting(
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
                        padding: const EdgeInsets.only(left: 10, right: 1),
                        child:
                            BlocBuilder<SettingScreenBloc, SettingScreenState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                context
                                    .read<SettingScreenBloc>()
                                    .add(SettingScreenLoggedOut());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15.0),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
