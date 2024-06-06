import 'package:core/data/models/teacher_detail.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/screens/settings/settings_screen/setting_screen.dart';

class ProfileAppBar extends StatefulWidget {
  final VoidCallback? onBack;
  final TeacherDetail user;

  const ProfileAppBar({
    super.key,
    this.onBack,
    required this.user,
  });

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    final userData = widget.user.info;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: const Icon(
                    Icons.arrow_back_ios_sharp,
                    size: 18,
                    color: AppColors.whiteBackground,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(userData.urlImage.mobile)),
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.white, width: 2)),
                ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    context.push(SettingScreen(
                      pushNotify: widget.user.pushNotify,
                    ));
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
