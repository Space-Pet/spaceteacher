import 'package:core/presentation/common_widget/circle_progress_bar/w_circle_progress_bar.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';

import 'package:teacher/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/observation_schedule/screen/hourly_assessment/hourly_assessment_submit_screen.dart';
import 'package:teacher/src/screens/observation_schedule/widgets/select_field.dart';
import 'package:core/presentation/extentions/extension_context.dart';

class HourAssessmentScreen extends StatefulWidget {
  static const routeName = '/hour_assessment';
  const HourAssessmentScreen({super.key});

  @override
  State<HourAssessmentScreen> createState() => _HourAssessmentScreenState();
}

class _HourAssessmentScreenState extends State<HourAssessmentScreen> {
  double valuePercent1 = 0;
  double valuePercent2 = 0;
  double valuePercent3 = 0;
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackGroundContainer(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                top: -20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 0),
                  child: ScreensAppBar(
                    '26 Th01,2024',
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
                        'Đánh giá dự giờ',
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Nguyễn Thị Hồng',
                                      style: AppTextStyles.bold16(
                                          color: AppColors.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Môn: Toán',
                                      style: AppTextStyles.semiBold14(
                                          color: AppColors.gray600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 15,
                                          backgroundColor: AppColors
                                              .observationStatusMyObsBG,
                                          // padding: const EdgeInsets.all(3.0),

                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Assets
                                                .icons.classIconHourassessment
                                                .svg(
                                              color: AppColors.white,
                                              width: 22,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Lớp: 3A',
                                          style: AppTextStyles.bold14(
                                              color: AppColors
                                                  .observationStatusMyObsBG),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: HalfCircularProgressBar(
                                  value: valuePercentAverage([
                                    valuePercent1,
                                    valuePercent2,
                                    valuePercent3
                                  ]),
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
                    SelectPercent(
                      hintText: 'Chuẩn bị bài trước khi đến lớp',
                      onPercentChanged: (newValue) async {
                        setState(() {
                          valuePercent1 =
                              double.parse(newValue.replaceAll('%', ''));
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SelectPercent(
                      hintText: 'Phát biểu',
                      onPercentChanged: (newValue) async {
                        setState(() {
                          valuePercent2 =
                              double.parse(newValue.replaceAll('%', ''));
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    SelectPercent(
                      hintText: 'Thảo luận nhóm',
                      onPercentChanged: (newValue) async {
                        setState(() {
                          valuePercent3 =
                              double.parse(newValue.replaceAll('%', ''));
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: AppColors.gray400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Viết đánh giá',
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
                                        Assets
                                            .icons.classIconHourassessment.path,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'GV: Nguyễn Thị Minh Nhi',
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
                              child: TextField(
                                controller: _textController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nhập đánh giá',
                                    hintStyle:
                                        TextStyle(color: AppColors.gray400)),
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
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
                      context.push(
                        HourAssessmentSubmitScreen.routeName,
                        arguments: {
                          'valuePercent': valuePercentAverage(
                              [valuePercent1, valuePercent2, valuePercent3]),
                          'name': "Nguyễn Thị Hồng",
                          'subject': "Toán",
                          'classRoom': "6.1",
                          'teacher': "Nguyễn Thị Minh Nhi",
                          'evaluation': _textController.text,
                          'valuePercentPrepareLessons': valuePercent1,
                          'valuePercentSpeak': valuePercent2,
                          'valuePercentGroupDiscussion': valuePercent3,
                          'date': '26 Th01,2024',
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.observationStatusMyObsBG,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Gửi đánh giá',
                      style: AppTextStyles.bold16(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double valuePercentAverage(List<double> values) {
    return values.reduce((value, element) => value + element) / values.length;
  }
}
