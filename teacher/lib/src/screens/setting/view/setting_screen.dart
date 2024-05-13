import 'package:core/core.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/main.dart';
import 'package:teacher/repository/auth_repository/auth_repositories.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/authentication/login/view/login_screen.dart';
import 'package:teacher/src/screens/setting/bloc/setting_screen_bloc.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:teacher/src/utils/extension_context.dart';
import 'package:teacher/src/utils/lang_utils.dart';

import '../widget/switch_setting.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = '/setting';
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
          settings: Injection.get<Settings>(),
          authRepository: Injection.get<AuthRepository>()),
      child: BlocListener<SettingScreenBloc, SettingScreenState>(
        listenWhen: (previous, current) =>
            previous.logoutStatus != current.logoutStatus,
        listener: (context, state) {
          if (state.logoutStatus.isSuccess) {
            navigatorKey.currentContext!.pushReplacement(LoginScreen.routeName);
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
        child: Scaffold(
          body: BackGroundContainer(
            child: Column(
              children: [
                ScreenAppBar(
                  title: 'account management'.tr(),
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
                            text: 'turn off noti'.tr(),
                            iconAsset: Assets.icons.bell.path,
                            showDottedLine: true,
                          ),
                        ),
                        SwitchSetting(
                          text: 'feedback'.tr(),
                          iconAsset: Assets.icons.message.path,
                          showDottedLine: true,
                          onPressed: () {},
                        ),
                        SwitchSetting(
                          showDottedLine: true,
                          text: 'user manual'.tr(),
                          iconAsset: Assets.icons.userManual.path,
                          onPressed: () {},
                        ),
                        SwitchSetting(
                          showDottedLine: true,
                          text: 'change account'.tr(),
                          iconAsset: Assets.icons.accountConversion.path,
                          onPressed: () {
                            // context.push(const ChangeAccountScreen());
                          },
                        ),
                        SwitchSetting(
                          showDottedLine: true,
                          text: 'change password'.tr(),
                          iconAsset: Assets.icons.message.path,
                          onPressed: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) =>
                            //       DialogChangePassword(
                            //     onClosePressed: () {
                            //       context.pop();
                            //     },
                            //     onSavePressed: () {
                            //       context.pop();
                            //     },
                            //   ),
                            // );
                          },
                        ),
                        SwitchSetting(
                          showDottedLine: true,
                          text: 'change wallpaper'.tr(),
                          iconAsset: Assets.icons.tablet.path,
                          onPressed: () {
                            // context.push(const ChangeWallpaperScreen());
                          },
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            Assets.icons.global.path,
                            height: 20,
                            width: 20,
                          ),
                          title: Text(
                            'change language'.tr(),
                            style: AppTextStyles.normal16(
                                color: AppColors.gray600),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  context.locale.languageCode.tr(),
                                  style: AppTextStyles.normal14(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CountryFlag.fromCountryCode(
                                  LangUtils.getLangCodeCountryFlag(
                                      context.locale.languageCode),
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: false,
                              builder: (BuildContext context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ChangeLanguageWidget(
                                    codeLanguage: 'vi',
                                    onPressed: () {
                                      context.setLocale(
                                        const Locale('vi', 'VN'),
                                      );
                                      context.pop();
                                    },
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: DottedLine(
                                      dashLength: 2,
                                      dashColor: AppColors.gray400,
                                    ),
                                  ),
                                  ChangeLanguageWidget(
                                    codeLanguage: 'en',
                                    onPressed: () {
                                      context.setLocale(
                                        const Locale('en', 'US'),
                                      );
                                      context.pop();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            );
                          },
                          contentPadding: const EdgeInsets.only(
                              left: 21, right: 21, bottom: 10),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 1),
                          child: BlocBuilder<SettingScreenBloc,
                              SettingScreenState>(
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Assets.icons.logout.svg(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          'logout'.tr(),
                                          style: const TextStyle(
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
      ),
    );
  }
}

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    required this.codeLanguage,
    required this.onPressed,
    super.key,
  });

  final String codeLanguage;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      leading: CountryFlag.fromCountryCode(
          LangUtils.getLangCodeCountryFlag(codeLanguage),
          width: 30,
          height: 30),
      title: Text(
        codeLanguage.tr(),
        style: AppTextStyles.semiBold16(),
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: AppColors.gray400,
      ),
      onTap: () => onPressed.call(),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
