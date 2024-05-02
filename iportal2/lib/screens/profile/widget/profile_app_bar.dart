import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/screens/settings/settings_screen/setting_screen.dart';
import 'package:network_data_source/network_data_source.dart';

class ProfileAppBar extends StatefulWidget {
  final VoidCallback? onBack;
  final int role;
  final StudentData user;
  const ProfileAppBar(
      {super.key, this.onBack, required this.role, required this.user});

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final userData = widget.user;

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
                          image: NetworkImage(userData.avatar.mobile)),
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.white, width: 2)),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.pupil.name,
                      style: AppTextStyles.semiBold12(
                        color: AppColors.white,
                        height: 24 / 12,
                      ),
                    ),
                    Text(
                      userData.classInfo.name,
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
                    context.push(const SettingScreen());
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: AppColors.white,
                  )),
              // if (widget.role == 1)
              //   IconButton(
              //     icon: const Icon(
              //       Icons.keyboard_arrow_down,
              //       color: AppColors.white,
              //     ),
              //     onPressed: () {
              //       showModalBottomSheet(
              //         context: context,
              //         isDismissible: false,
              //         enableDrag: false,
              //         isScrollControlled: true,
              //         backgroundColor: Colors.transparent,
              //         builder: (context) {
              //           return ProfileBottomSheet(
              //             onIndexChanged: () {},
              //           );
              //         },
              //       );
              //     },
              //   ),
            ],
          )
        ],
      ),
    );
  }
}
