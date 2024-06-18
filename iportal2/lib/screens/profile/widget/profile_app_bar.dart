import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/profile/widget/profile_bottom_sheet.dart';
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

    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final listChildren = state.user.children;

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
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.white,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/default-user.png',
                          image: studentData.avatar.mobile,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/default-user.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
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
                    if (widget.isParent && listChildren.length > 1)
                      IconButton(
                        padding: const EdgeInsets.only(left: 16),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) =>
                                const SelectChildrenBottomSheet(),
                          );
                        },
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
      },
    );
  }
}
