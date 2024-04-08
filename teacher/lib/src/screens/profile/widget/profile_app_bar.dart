import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/model/student_model.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/profile/widget/profile_bottom_sheet.dart';
import 'package:teacher/src/screens/setting/view/setting_screen.dart';
import 'package:teacher/src/utils/extension_context.dart';
import 'package:teacher/src/utils/user_manager.dart';

class ProfileAppBar extends StatefulWidget {
  final VoidCallback? onBack;
  final int role;

  final StudentModel studentModel;
  const ProfileAppBar(
      {super.key, this.onBack, required this.role, required this.studentModel});

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  bool isExpanded = false;
  UserManager userManager = UserManager.instance;
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
                      '${widget.studentModel.pupilModel?.name}',
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
                            '${widget.studentModel.school?.name}',
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
                            '${widget.studentModel.classModel?.name}',
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
                  onPressed: () async {
                    context.push(SettingScreen.routeName);
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
