import 'package:flutter/material.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';

class SplashContent extends StatelessWidget {
  final String title1;
  final String? title2;
  final String? title2Red;
  final String? title3;
  final String? title3Red;
  final String text1;
  final String? text2;
  final String image;
  final int index;

  const SplashContent({
    super.key,
    required this.title1,
    this.title2,
    this.title3,
    this.title2Red,
    this.title3Red,
    required this.text1,
    this.text2,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 120),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 160,
            child: Column(
              mainAxisAlignment: index == 0
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      title1,
                      style: AppTextStyles.bold26(),
                    ),
                    if (title2 != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title2!,
                            style: AppTextStyles.bold26(),
                          ),
                          if (title2Red != '')
                            Text(
                              title2Red!,
                              style: AppTextStyles.bold26(
                                color: AppColors.brand500,
                              ),
                            ),
                        ],
                      ),
                    if (title3 != '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title3!,
                            style: AppTextStyles.bold26(),
                          ),
                          Text(
                            title3Red!,
                            style: AppTextStyles.bold26(
                              color: AppColors.brand500,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (index == 0) const SizedBox(height: 32),
                Column(
                  children: [
                    Text(
                      text1,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.normal14(
                        color: AppColors.gray79,
                      ),
                    ),
                    if (text2 != '')
                      Text(
                        text2!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.normal14(
                          color: AppColors.gray79,
                        ),
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

final splashContent = [
  {
    'title1': 'Quản lý hoạt động',
    'title2': 'học tập',
    'title2Red': '',
    'title3': '',
    'title3Red': '',
    'text1': 'Xem kết quả học tập của học sinh',
    'text2': '',
    'image': Assets.images.splash.splashScreen1.path,
  },
  {
    'title1': 'Cổng thông tin kết',
    'title2': 'nối giữa',
    'title2Red': ' nhà trường',
    'title3': 'và',
    'title3Red': ' gia đình',
    'text1': 'Gửi thông báo, tin nhắn và báo cáo đến Cha',
    'text2': 'mẹ và học sinh để tối ưu hóa giao tiếp.',
    'image': Assets.images.splash.splashScreen2.path,
  },
  {
    'title1': 'Đồng hành cùng',
    'title2': 'Phụ huynh và Học sinh',
    'title2Red': '',
    'title3': '',
    'title3Red': '',
    'text1': 'Cung cấp thông tin và hỗ trợ để đảm bảo học',
    'text2': 'sinh phát triển tối ưu trong học vụ.',
    'image': Assets.images.splash.splashScreen3.path,
  },
];
