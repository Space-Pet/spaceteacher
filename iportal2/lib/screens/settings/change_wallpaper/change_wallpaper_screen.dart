import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/check_box/check_box.dart';
import 'package:iportal2/screens/settings/widget/setting_app_bar.dart';
import 'package:iportal2/resources/app_strings.dart';
import 'package:iportal2/resources/app_text_styles.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/assets.gen.dart';

class ChangeWallpaperScreen extends StatefulWidget {
  const ChangeWallpaperScreen({super.key});

  @override
  State<ChangeWallpaperScreen> createState() => _ChangeWallpaperScreenState();
}

class _ChangeWallpaperScreenState extends State<ChangeWallpaperScreen> {
  List<bool> checkboxStates = List.generate(
    1,
    (index) => false,
  );

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        children: [
          ScreenAppBar(
            canGoback: true,
            onBack: () {
              context.pop();
            },
            title: AppStrings.changeWallpaper,
          ),
          Flexible(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 22, bottom: 22),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckBoxItem(
                            title: 'Nền UKA',
                            isChecked: checkboxStates[index],
                            svgAssetPath: Assets.icons.wallpaper,
                            onTap: (isChecked) {
                              setState(() {
                                checkboxStates[index] = isChecked;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.redMenu),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Cập nhật',
                                style: AppTextStyles.normal16(
                                    fontWeight: FontWeight.w600,
                                    height: 0.09,
                                    color: AppColors.white),
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
