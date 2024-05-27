import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/check_box/check_box.dart';

import '../../../resources/assets.gen.dart';

class ChangeWallpaperScreen extends StatelessWidget {
  const ChangeWallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final bgState = state.background;
        final bloc = context.read<CurrentUserBloc>();
        final userRepository = context.read<UserRepository>();

        final listOption = List.generate(backGroundItems.length, (index) {
          final it = backGroundItems[index];
          return InkWell(
            onTap: () {
              bloc.add(BackGroundUpdatedState(bg: it.schoolBrand));
            },
            child: CheckBoxItem(
              title: it.title,
              svgAssetPath: it.svgAssetPath,
              isChecked: it.schoolBrand == bgState,
            ),
          );
        });

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
                        Expanded(child: Column(children: listOption)),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  context.loaderOverlay.show();

                                  final newUser = state.user.copyWith(
                                    background: bgState,
                                  );

                                  userRepository.saveUser(newUser);
                                  bloc.add(CurrentUserUpdated(user: newUser));

                                  context.loaderOverlay.hide();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Cập nhật thành công!'),
                                  ));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
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
      },
    );
  }
}

class BackGroundItem {
  final String title;
  final String svgAssetPath;
  final bool isChecked;
  final SchoolBrand schoolBrand;

  BackGroundItem({
    required this.title,
    required this.svgAssetPath,
    required this.isChecked,
    required this.schoolBrand,
  });
}

List<BackGroundItem> backGroundItems = [
  BackGroundItem(
    schoolBrand: SchoolBrand.uka,
    title: 'Nền UKA',
    svgAssetPath: Assets.icons.brandBackground.uka.path,
    isChecked: false,
  ),
  BackGroundItem(
    schoolBrand: SchoolBrand.ischool,
    title: 'Nền iSchool',
    svgAssetPath: Assets.icons.brandBackground.ischool.path,
    isChecked: false,
  ),
  BackGroundItem(
    schoolBrand: SchoolBrand.sga,
    title: 'Nền SGA',
    svgAssetPath: Assets.icons.brandBackground.sga.path,
    isChecked: false,
  ),
  BackGroundItem(
    schoolBrand: SchoolBrand.sna,
    title: 'Nền SNA',
    svgAssetPath: Assets.icons.brandBackground.sna.path,
    isChecked: false,
  ),
  BackGroundItem(
    schoolBrand: SchoolBrand.iec,
    title: 'Nền IEC',
    svgAssetPath: Assets.icons.brandBackground.iec.path,
    isChecked: false,
  ),
];
