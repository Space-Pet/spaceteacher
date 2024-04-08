import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

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

  void saveData() async {
    await Hive.openBox('boxBestEnglish');
    final box = Hive.box('boxBestEnglish');
    box.put('is_first_time', false);
  }

  @override
  Widget build(BuildContext context) {
    saveData();

    return Container(
      padding: const EdgeInsets.only(bottom: 120),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill,
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
    'image': 'assets/images/image3.png',
  },
  {
    'title1': 'Cổng thông tin kết',
    'title2': 'nối giữa',
    'title2Red': ' nhà trường',
    'title3': 'và',
    'title3Red': ' gia đình',
    'text1': 'Gửi thông báo, tin nhắn và báo cáo đến phụ',
    'text2': 'huynh và học sinh để tối ưu hóa giao tiếp.',
    'image': 'assets/images/image2.png',
  },
  {
    'title1': 'Đồng hành cùng Cha mẹ',
    'title2': 'học sinh và Học sinh',
    'title2Red': '',
    'title3': '',
    'title3Red': '',
    'text1': 'Cung cấp thông tin và hỗ trợ học sinh trong',
    'text2': 'học tập',
    'image': 'assets/images/image4.png',
  },
];
