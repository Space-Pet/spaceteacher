import 'package:flutter/material.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/resources/resources.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    required this.userInfo,
    super.key,
  });
  final UserInfo userInfo;
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
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: Image.network("${userInfo.schoolLogo}") 
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userInfo.name ?? 'Nguyễn Ngọc Tuyết Lan',
                      style: AppTextStyles.semiBold12(
                        color: AppColors.white,
                        height: 24 / 12,
                      ),
                    ),
                    Text(
                      userInfo.className ?? 'Lớp 6.1',
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
