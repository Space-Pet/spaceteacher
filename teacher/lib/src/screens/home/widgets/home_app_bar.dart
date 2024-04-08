import 'package:flutter/material.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/profile/view/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.user,
  });

  final UserInfo user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 36, 8, 28),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProfileScreen.routeName,
                arguments: {
                  'userInfo': user,
                },
              );
            },
            child: CircleAvatar(
              backgroundColor: AppColors.whiteBackground,
              radius: 21,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.transparent,
                child: Image.network("${user.schoolLogo}"),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.name}",
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${user.className}",
                style: const TextStyle(color: AppColors.white, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: AppColors.whiteOpacity.withOpacity(0.3),
            radius: 20,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              child: Assets.images.noti.image(),
            ),
          ),
        ],
      ),
    );
  }
}
