import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/screens/profile/profile_screen.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(const ProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                ),
                const SizedBox(width: 8),
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
                    Text(
                      'Lớp 6.1',
                      style: AppTextStyles.normal12(
                        color: AppColors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 0.205),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/noti.png'),
            ),
          ),
        ],
      ),
    );
  }
}
