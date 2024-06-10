import 'package:core/core.dart';
import 'package:core/presentation/common_widget/circle_progress_bar/w_circle_progress_bar.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/utils/extension_context.dart';

class HourAssessmentSubmitScreen extends StatefulWidget {
  static const routeName = '/hour_assessment_submit';
  const HourAssessmentSubmitScreen(
      {super.key,
      required this.valuePercent,
      required this.name,
      required this.subject,
      required this.classRoom,
      required this.valuePercentPrepareLessons,
      required this.valuePercentSpeak,
      required this.valuePercentGroupDiscussion,
      required this.evaluation,
      required this.teacher,
      required this.date});
  final double valuePercent;
  final String name;
  final String subject;
  final String classRoom;
  final double valuePercentPrepareLessons;
  final double valuePercentSpeak;
  final double valuePercentGroupDiscussion;
  final String evaluation;
  final String teacher;
  final String date;
  @override
  State<HourAssessmentSubmitScreen> createState() =>
      _HourAssessmentSubmitScreenState();
}

class _HourAssessmentSubmitScreenState
    extends State<HourAssessmentSubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              top: -20,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                child: ScreensAppBar(
                  widget.date,
                  canGoBack: true,
                  onBack: () {
                    context.pop();
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10, 12, 0),
                    child: Text(
                      'Kết quả đánh giá dự giờ',
                      style: AppTextStyles.bold18(color: AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.16,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Assets.images.hourAssessmentBgheader
                                  .provider(),
                              fit: BoxFit.fill),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.name,
                                    style: AppTextStyles.bold16(
                                        color: AppColors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Môn: ${widget.subject}',
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.gray600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: HalfCircularProgressBar(
                                value: widget.valuePercent,
                                fillColor: AppColors.observationStatusMyObsBG,
                                backgroundColor: AppColors.gray400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.observationCardDetailDotted),
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 15,
                              backgroundColor:
                                  AppColors.observationStatusMyObsBG,
                              // padding: const EdgeInsets.all(3.0),

                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Assets.icons.classIconHourassessment.svg(
                                  color: AppColors.white,
                                  width: 22,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Lớp: ${widget.classRoom}',
                              style: AppTextStyles.bold14(
                                  color: AppColors.observationStatusMyObsBG),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Chuẩn bị bài trước khi đến lớp',
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.gray700),
                                  ),
                                  Text(
                                    '${widget.valuePercentPrepareLessons.floor()}%',
                                    style: AppTextStyles.bold14(
                                        color:
                                            AppColors.observationStatusMyObsBG),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppColors.gray300,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hợp tác',
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.gray700),
                                  ),
                                  Text(
                                    passedOrNot(
                                        widget.valuePercentGroupDiscussion),
                                    style: AppTextStyles.bold14(
                                        color: AppColors.blueForgorPassword),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppColors.gray300,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tự học, tự giải quyết vấn đề',
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.gray700),
                                  ),
                                  Text(
                                    passedOrNot(widget.valuePercentSpeak),
                                    style: AppTextStyles.bold14(
                                        color: AppColors.blueForgorPassword),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Đánh giá',
                                    style: AppTextStyles.bold14(
                                        color: AppColors.blueForgorPassword),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 15,
                                        backgroundColor:
                                            AppColors.observationStatusMyObsBG,
                                        child: SvgPicture.asset(
                                          Assets.icons.classIconHourassessment
                                              .path,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'GV: ${widget.teacher}',
                                        style: AppTextStyles.normal12(
                                            color: AppColors.gray400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppColors.gray300,
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: Text(
                                  textAlign: TextAlign.start,
                                  isNullOrEmpty(widget.evaluation)
                                      ? 'Không có đánh giá'
                                      : widget.evaluation,
                                  maxLines: null,
                                  style: AppTextStyles.normal14(
                                    color: AppColors.gray500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    context.pop();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.observationStatusMyObsBG,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Đóng',
                    style: AppTextStyles.bold16(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String passedOrNot(double value) {
    if (value < 50) {
      return 'K';
    } else {
      return 'Đ';
    }
  }
}
