import 'package:core/core.dart';
import 'package:core/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/dialog/dialog_change_password.dart';
import 'package:iportal2/components/dialog/dialog_languages.dart';
import 'package:iportal2/components/dialog/dialog_scale_animated.dart';
import 'package:iportal2/screens/authentication/domain/domain_screen.dart';
import 'package:iportal2/screens/settings/change_account_screen/change_account.dart';
import 'package:iportal2/screens/settings/change_wallpaper/change_wallpaper_screen.dart';
import 'package:iportal2/screens/settings/settings_screen/bloc/setting_screen_bloc.dart';
import 'package:iportal2/screens/settings/widget/show_dialog_logout.dart';
import 'package:iportal2/screens/settings/widget/switch_setting.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    required this.userData,
    required this.parentData,
    this.isParent = false,
  });

  final StudentData userData;
  final ParentData parentData;
  final bool isParent;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final settingBloc = SettingScreenBloc(
      appFetchApiRepo: context.read<AppFetchApiRepository>(),
      authRepository: context.read<AuthRepository>(),
      userRepository: context.read<UserRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
    );

    final isDisableNoti = widget.isParent
        ? widget.parentData.pushNotify == 0
        : widget.userData.pupil.pushNotify == 0;

    return BlocProvider.value(
      value: settingBloc,
      child: BlocListener<SettingScreenBloc, SettingScreenState>(
        listenWhen: (previous, current) =>
            previous.logoutStatus != current.logoutStatus,
        listener: (context, state) {
          if (state.logoutStatus.isSuccess) {
            Navigator.pushAndRemoveUntil(
              mainNavKey.currentContext!,
              MaterialPageRoute(builder: (context) => const DomainScreen()),
              (route) => false,
            );
          }

          if (state.logoutStatus.isTurnOffNotiSuccess) {
            SnackBarUtils.showFloatingSnackBar(context, 'Cập nhật thành công!');
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
                      BlocBuilder<CurrentUserBloc, CurrentUserState>(
                        builder: (context, state) {
                          final pushNotify = state.pushNotify;
                          final currentUserBloc =
                              context.read<CurrentUserBloc>();

                          final updateValue = pushNotify == 0 ? 1 : 0;

                          return Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: AccountSetting(
                              text: AppStrings.turnOffNoti,
                              iconAsset: Assets.icons.bell,
                              isDisableNoti: pushNotify == 0,
                              isNotiSetting: true,
                              onPressed: () {
                                settingBloc.add(TurnOffNoti(
                                  pushNotify: updateValue,
                                ));

                                currentUserBloc
                                    .add(CurrentUserNotify(updateValue));
                              },
                            ),
                          );
                        },
                      ),
                      AccountSetting(
                        text: AppStrings.userManual,
                        iconAsset: Assets.icons.userManual,
                        onPressed: onViewGuide,
                      ),
                      AccountSetting(
                        text: 'FAQ',
                        iconAsset: Assets.icons.faq,
                        onPressed: onViewGuide,
                      ),
                      if (widget.isParent &&
                          widget.parentData.children.length > 1)
                        AccountSetting(
                          text: AppStrings.changeAccount,
                          iconAsset: Assets.icons.accountConversion,
                          onPressed: () {
                            context.push(const ChangeAccountScreen());
                          },
                        ),
                      BlocBuilder<SettingScreenBloc, SettingScreenState>(
                          builder: (context, state) {
                        return AccountSetting(
                          text: 'Đổi mật khẩu',
                          iconAsset: Assets.icons.lockPassword,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => DialogScaleAnimated(
                                        dialogContent: DialogChangePassword(
                                      bloc: settingBloc,
                                    )));
                          },
                        );
                      }),
                      AccountSetting(
                        text: AppStrings.changeWallpaper,
                        iconAsset: Assets.icons.tablet,
                        onPressed: () {
                          context.push(const ChangeWallpaperScreen());
                        },
                      ),
                      AccountSetting(
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
                        child:
                            BlocBuilder<SettingScreenBloc, SettingScreenState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                ShowDialogLogout.show(
                                  context,
                                  text:
                                      'Bạn có chắc chắn muốn đăng xuất không?',
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onViewGuide() {
    launchUrl(
      Uri.parse('https://istudy.edu.vn/mod/book/view.php?id=40104'),
      mode: LaunchMode.inAppBrowserView,
    );
  }
}
