import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iportal2/components/buttons/rounded_button.dart';
import 'package:iportal2/components/home_shadow_box.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ImagesLibrary extends StatelessWidget {
  const ImagesLibrary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaDowBoxContainer(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 13,
                    backgroundColor: AppColors.red,
                    child: SvgPicture.asset(
                      'assets/icons/file.svg',
                      width: 14,
                      height: 14,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Thư viện ảnh hoạt động',
                      style: AppTextStyles.semiBold14(
                        color: AppColors.blueGray800,
                      ),
                    ),
                  ),
                ],
              ),
              RoundedButton(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                borderRadius: 12,
                border: Border.all(
                  color: AppColors.gray300,
                ),
                buttonColor: AppColors.white,
                child: Text(
                  'Xem thêm',
                  style: AppTextStyles.normal12(color: AppColors.gray600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 120,
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/example1.png',
                        fit: BoxFit.cover,
                        height: 105,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 2, 4),
                          child: Text(
                            'Hoạt động ngoại khoá 01/2024 lớp mầm',
                            style: AppTextStyles.normal12(
                              color: AppColors.gray600,
                            ),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
