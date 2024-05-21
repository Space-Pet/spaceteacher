import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_text_styles.dart';

import '../screens/profile/widget/profile_bottom_sheet.dart';

class SelectChild extends StatelessWidget {
  const SelectChild({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
      final user = state.user;
      return Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  user.children[0].url_image.mobile)),
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          border: Border.all(color: AppColors.white, width: 2)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: AppTextStyles.semiBold16(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            // SvgPicture.asset(
                            //   Assets.icons.academic,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 6),
                            //   child: Text(
                            //     'UKA Vũng Tàu',
                            //     style: AppTextStyles.normal12(
                            //       color: AppColors.gray500,
                            //     ),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 6),
                            //   child: Container(
                            //     width: 5,
                            //     height: 5,
                            //     decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       color: AppColors.gray500,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                user.class_name,
                                style: AppTextStyles.normal12(
                                  color: AppColors.gray500,
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
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.black,
                            size: 30,
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
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    });
  }
}
