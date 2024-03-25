import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/profile/widget/profile_bottom_sheet.dart';
import 'package:iportal2/screens/settings/settings_screen/setting_screen.dart';

class ProfileAppBar extends StatefulWidget {
  final VoidCallback? onBack;
  final int role;
  const ProfileAppBar({super.key, this.onBack, required this.role});

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(widget.role == 0
                      ? 'assets/images/avatar.png'
                      : 'assets/images/image_parent.png'),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Ngọc Tuyết Lan',
                      style: AppTextStyles.semiBold12(
                        color: AppColors.white,
                        height: 24 / 12,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icons.academic),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            'UKA Vũng Tàu',
                            style: AppTextStyles.normal12(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Text(
                            '6.1',
                            style: AppTextStyles.normal12(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
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
              if (widget.role == 1)
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ProfileBottomSheet(
                          onIndexChanged: () {},
                        );
                      },
                    );
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}
