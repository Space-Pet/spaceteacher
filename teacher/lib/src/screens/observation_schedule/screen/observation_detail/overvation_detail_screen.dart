import 'package:flutter/material.dart';
import 'package:teacher/components/app_bar/screen_app_bar.dart';

import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/dialog/dilaog_yes_no.dart';

import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/observation_schedule/mock_data/subject_mock.dart';
import 'package:teacher/src/screens/observation_schedule/screen/hourly_assessment/hourly_assessment_screen.dart';
import 'package:teacher/src/screens/observation_schedule/screen/observation_detail/widget/line_text_observation.dart';
import 'package:teacher/src/utils/extension_context.dart';

class ObservationDetailScreen extends StatefulWidget {
  static const routeName = '/observation_detail';
  const ObservationDetailScreen(
      {required this.data, required this.typeObservation, super.key});

  final MockSubjectData data;
  final int typeObservation;
  @override
  State<ObservationDetailScreen> createState() =>
      _ObservationDetailScreenState();
}

class _ObservationDetailScreenState extends State<ObservationDetailScreen> {
  final List<LineTextObservationDetail> listLineText = [];

  @override
  void initState() {
    listLineText.addAll([
      const LineTextObservationDetail(
        title: 'Thời gian dự giờ',
        value: '29/02/2024',
        isFirstLine: true,
      ),
      LineTextObservationDetail(
        title: 'Môn',
        value: widget.data.subjectModel?.subjectName ?? "",
        isFirstLine: false,
      ),
      LineTextObservationDetail(
        title: 'Giáo viên',
        value: widget.data.subjectModel?.teacherName ?? "",
        isFirstLine: false,
      ),
      LineTextObservationDetail(
        title: 'Lớp',
        value: widget.data.subjectModel?.className ?? "",
        isFirstLine: false,
      ),
      LineTextObservationDetail(
        title: 'Tiết',
        value: '${widget.data.subjectModel?.tietNum}',
        isFirstLine: false,
      ),
      LineTextObservationDetail(
        title: widget.data.descriptionSubjectLesson ?? "",
        value: '',
        isFirstLine: false,
        isLastLine: true,
      ),
    ]);
    super.initState();
  }

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
                  Column(children: listLineText),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      'Giáo viên tham gia dự giờ',
                      style: AppTextStyles.bold18(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: CardTeacherJoinObservation(
                            teacherName: 'Nguyễn Tố Loan',
                            teacherJob: 'Giáo viên Toán',
                            classRoom: '6.4',
                            avtarUrl: '',
                          ),
                        );
                      },
                      itemCount: 5,
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
                    if (widget.typeObservation == 3 ||
                        widget.typeObservation == 4) {
                      showGeneralDialog(
                          context: context,
                          routeSettings: const RouteSettings(
                              name: HourAssessmentScreen.routeName),
                          pageBuilder: (context, anim1, anim2) {
                            return const HourAssessmentScreen();
                          });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogYesNo(
                            title: 'Mở lớp dự giờ thành công',
                            content: 'Giáo viên Anh Văn - Nguyễn Tấn Lộc',
                            typeDialog: 3,
                            yesText: "Xác nhận",
                            noText: "Đóng",
                            subjectModel: widget.data.subjectModel,
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.observationStatusMyObsBG,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.typeObservation == 3 ||
                                widget.typeObservation == 4
                            ? Icons.edit_document
                            : Icons.add,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.typeObservation == 3 ||
                                widget.typeObservation == 4
                            ? 'Đánh giá dự giờ'
                            : 'Gửi yêu cầu tham gia',
                        style: AppTextStyles.bold16(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardTeacherJoinObservation extends StatelessWidget {
  const CardTeacherJoinObservation({
    super.key,
    required this.teacherName,
    required this.teacherJob,
    required this.classRoom,
    required this.avtarUrl,
  });

  final String teacherName;
  final String teacherJob;
  final String classRoom;
  final String avtarUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.observationCardDetailbg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.observationCardDetailDotted,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            maxRadius: 25,
            child: Icon(
              Icons.person,
              color: AppColors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teacherName,
                style: AppTextStyles.bold14(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.work_outline, color: AppColors.gray79),
                  const SizedBox(width: 5),
                  Text(
                    teacherJob,
                    style: AppTextStyles.normal12(color: AppColors.gray79),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 10,
                    width: 5,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.gray79),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    classRoom,
                    style: AppTextStyles.normal14(color: AppColors.gray79),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
