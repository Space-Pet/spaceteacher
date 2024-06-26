import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

import '../../../resources/app_strings.dart';
import '../../../resources/assets.gen.dart';

class ChangeAccountScreen extends StatelessWidget {
  const ChangeAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int childCount = 2;

    return BackGroundContainer(
      child: Column(
        children: [
          ScreenAppBar(
            title: AppStrings.titleChangeAccount,
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Flexible(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 21, right: 21, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.seeInfomation,
                    style: AppTextStyles.bold16(),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          final islastIndex = index == childCount - 1;
                          return Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 17, bottom: 27),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                AppColors.whiteBackground,
                                            child: Image.asset(
                                                'assets/images/avatar.png'),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Nguyễn Ngọc Tuyết Lan',
                                                style: AppTextStyles.bold16(),
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Assets.icons.academic,
                                                    color: AppColors.gray500,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      'UKA Vũng Tàu',
                                                      style: AppTextStyles
                                                          .normal12(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Container(
                                                      width: 5,
                                                      height: 5,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            AppColors.gray300,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      '6.1',
                                                      style: AppTextStyles
                                                          .normal12(
                                                        color: AppColors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.keyboard_arrow_right,
                                            size: 24,
                                          ))
                                    ],
                                  ),
                                ),
                                if (!islastIndex)
                                  DottedLine(
                                    dashLength: 2,
                                    dashColor: AppColors.gray400,
                                  )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
