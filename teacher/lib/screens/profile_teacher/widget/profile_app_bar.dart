import 'package:core/data/models/teacher_detail.dart';
import 'package:core/presentation/common_widget/default_circle_ava.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/settings/settings_screen/setting_screen.dart';

class ProfileAppBar extends StatelessWidget {
  final TeacherDetail user;

  const ProfileAppBar({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final userData = user.info;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 18,
                    color: AppColors.whiteBackground,
                  ),
                  const SizedBox(width: 4),
                  CircleAvaImage(urlAva: userData.urlImage.mobile),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData.fullName,
                        style: AppTextStyles.semiBold12(
                          color: AppColors.white,
                          height: 24 / 12,
                        ),
                      ),
                      Text(
                        userData.mainSubject,
                        style: AppTextStyles.normal12(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    context.push(const SettingScreen());
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: AppColors.white,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
