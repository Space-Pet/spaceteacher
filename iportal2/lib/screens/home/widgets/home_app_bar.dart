import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/message/message_screen.dart';
import 'package:iportal2/screens/profile/profile_screen.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final urlImage = state.user.children.url_image.mobile;
        final hasNoImage = urlImage.isEmpty;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: InkWell(
            onTap: () {
              context.push(const ProfileScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    state.user.children.url_image.mobile)),
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            border:
                                Border.all(color: AppColors.white, width: 2)),
                      ),
                      // Container(
                      //   height: 42,
                      //   width: 42,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(
                      //       color: hasNoImage
                      //           ? Colors.transparent
                      //           : AppColors.white,
                      //     ),
                      //   ),
                      //   child: SvgPicture.asset(
                      //     Assets.icons.defaultAva,
                      //   ),
                      // ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.user.name,
                            style: AppTextStyles.semiBold12(
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            'Lớp ${state.user.class_name}',
                            style: AppTextStyles.normal12(
                              color: AppColors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push(const MessageScreen());
                  },
                  child: CircleAvatar(
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 0.205),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/noti.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
