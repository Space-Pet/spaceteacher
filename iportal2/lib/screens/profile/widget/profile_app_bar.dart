import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/settings/settings_screen/setting_screen.dart';
import 'package:network_data_source/network_data_source.dart';

class ProfileAppBar extends StatefulWidget {
  final VoidCallback? onBack;
  final StudentData studentData;
  final ParentData parentData;
  final bool isParent;

  const ProfileAppBar({
    super.key,
    this.onBack,
    required this.studentData,
    required this.parentData,
    required this.isParent,
  });

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final studentData = widget.studentData;

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
                          image: NetworkImage(studentData.avatar.mobile)),
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.white, width: 2)),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentData.pupil.name,
                      style: AppTextStyles.semiBold12(
                        color: AppColors.white,
                        height: 24 / 12,
                      ),
                    ),
                    Text(
                      'Lớp ${studentData.classInfo.name}',
                      style: AppTextStyles.normal12(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                if (widget.isParent)
                  IconButton(
                    padding: const EdgeInsets.only(left: 16),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.white,
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    context.push(SettingScreen(
                      userData: studentData,
                      parentData: widget.parentData,
                      isParent: widget.isParent,
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
