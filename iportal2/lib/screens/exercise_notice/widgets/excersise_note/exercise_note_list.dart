import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_decoration.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/utils/validation_functions.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:url_launcher/url_launcher.dart';

class ExerciseItemList extends StatelessWidget {
  const ExerciseItemList({
    super.key,
    required this.exercise,
    required this.selectedSubject,
    this.isTodayView = false,
    this.isHomeScreenView = false,
  });

  final List<ExerciseItem> exercise;
  final String selectedSubject;
  final bool isTodayView;
  final bool isHomeScreenView;

  @override
  Widget build(BuildContext context) {
    List<ExerciseItem> filteredExerciseList =
        selectedSubject == "Tất cả các môn"
            ? exercise
            : exercise
                .where((item) => item.subjectName == selectedSubject)
                .toList();

    final listInstructionW =
        List.generate(filteredExerciseList.length, (index) {
      final exerCise = filteredExerciseList[index];

      final filePath = exerCise.fileBaoBai ?? '';
      final fileName = getFileName(filePath);

      return Container(
        margin: EdgeInsets.only(bottom: isHomeScreenView ? 6 : 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray300),
          borderRadius: AppRadius.rounded20,
          color: AppColors.white,
        ),
        child: isTodayView
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exerCise.subjectName,
                    style: AppTextStyles.bold14(
                      color: AppColors.black20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'GV: Nguyễn Huỳnh Vi Khương',
                    style: AppTextStyles.normal14(
                      color: AppColors.gray600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (exerCise.danDoBaoBai != null)
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/advice.svg'),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            exerCise.danDoBaoBai!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyles.normal14(
                              color: AppColors.gray600,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.blueGray100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      exerCise.subjectName,
                      style: AppTextStyles.normal14(color: AppColors.brand600),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (exerCise.hanNopBaoBai != null)
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock-time.svg',
                          width: 14,
                          height: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Hạn nộp: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(exerCise.hanNopBaoBai!))}',
                          style: AppTextStyles.normal14(
                            color: AppColors.brand600,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (exerCise.fileBaoBai!.isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        launchUrl(
                          Uri.parse(
                              'https://${exerCise.fileBaoBaiDomain}/${exerCise.fileBaoBai}'),
                          mode: LaunchMode.inAppBrowserView,
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/paperclip.svg'),
                          const SizedBox(width: 4),
                          Text(
                            fileName,
                            style: AppTextStyles.normal14(
                                color: AppColors.brand600),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
      );
    });

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: isHomeScreenView ? AppColors.gray100 : AppColors.white,
      ),
      padding: EdgeInsets.all(isHomeScreenView ? 8 : 0),
      child: Column(
        children: listInstructionW,
      ),
    );
  }
}

final List<ExerciseModel> exercises = [
  ExerciseModel(
    id: 1,
    number: 1,
    subjectname: 'Toán',
    name: 'Bài tập cuối tuần',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    description: 'Học sinh chuẩn bị bài kỹ trước khi đến lớp.',
    duetime: '22:00',
    duedate: '01/02/2024',
    fileName: 'Baitap29',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  ExerciseModel(
    id: 2,
    number: 2,
    subjectname: 'Vật lý',
    name: 'Chuẩn bị bài UNIT 7',
    teacherAva:
        'https://www.shutterstock.com/image-vector/female-character-portrait-smiling-young-260nw-312909497.jpg',
    description: 'Soạn bài, chuẩn bị bài trước khi đến lớp',
    duetime: '22:00',
    duedate: '01/02/2024',
    fileName: 'Baitap29',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  ExerciseModel(
    id: 3,
    number: 3,
    subjectname: 'Hóa học',
    name: 'Ôn Tập Hình học',
    teacherAva:
        'https://c8.alamy.com/comp/T5EY8E/female-teacher-avatar-character-vector-illustration-design-T5EY8E.jpg',
    description: 'Soạn bài, chuẩn bị bài trước khi đến lớp',
    duetime: '22:00',
    duedate: '01/02/2024',
    fileName: 'Baitap29',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  ExerciseModel(
    id: 4,
    number: 4,
    name: 'Đề cương kiểm tra 1 tiết',
    teacherAva:
        'https://t3.ftcdn.net/jpg/02/00/91/10/360_F_200911053_4ygtfQ75mb72sGYeHDfyl2JF4aiTtT0n.jpg',
    subjectname: 'Hóa học',
    description:
        'Học sinh chuẩn bị trước các câu ví dụ cho UNIT 7, bạn làm tốt nhất sẽ có thưởng nhé!',
    duetime: '22:00',
    duedate: '01/02/2024',
    fileName: 'Baitap29',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  ExerciseModel(
    id: 5,
    number: 5,
    subjectname: 'Tiếng Anh',
    name: 'Đề cương kiểm tra 1 tiết',
    teacherAva:
        'https://thumbs.dreamstime.com/z/female-teacher-avatar-character-female-teacher-avatar-character-vector-illustration-design-145742021.jpg',
    description:
        'Học sinh chuẩn bị trước các câu ví dụ cho UNIT 7, bạn làm tốt nhất sẽ có thưởng nhé!',
    duetime: '22:00',
    duedate: '01/02/2024',
    fileName: 'Baitap29',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
];
