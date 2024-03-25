import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iportal2/resources/app_colors.dart';

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
    EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 130);

    if (index == 1) {
      padding = const EdgeInsets.only(bottom: 115);
    } else if (index == 2) {
      padding = const EdgeInsets.only(bottom: 140);
    }
    return Container(
        // margin: index != 1
        //     ? const EdgeInsets.only(top: 40)
        //     : const EdgeInsets.only(top: 30),
        padding: padding,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          title1,
                          style: const TextStyle(
                            fontSize: 26,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (title2 != '')
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title2!,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (title2Red != '')
                                Text(
                                  title2Red!,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.red),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      if (title3 != '')
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title3!,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                title3Red!,
                                style: const TextStyle(
                                  color: AppColors.red,
                                  fontSize: 26,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Text(
                          text1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            color: AppColors.gray400,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      if (text2 != '')
                        Flexible(
                          child: Text(
                            text2!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              color: AppColors.gray400,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                    ],
                  ),
                ))
          ],
        ));
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
    'title1': 'Đồng hành cùng',
    'title2': 'Phụ huynh và Học sinh',
    'title2Red': '',
    'title3': '',
    'title3Red': '',
    'text1': 'Cung cấp thông tin và hỗ trợ để đảm bảo học',
    'text2': 'sinh phát triển tối ưu trong học vụ.',
    'image': 'assets/images/image4.png',
  },
];
