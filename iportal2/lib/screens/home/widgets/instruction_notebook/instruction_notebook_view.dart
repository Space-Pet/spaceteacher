import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/components/home_shadow_box.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/home/bloc/home_bloc.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/home_tab_instruction.dart';
import 'package:iportal2/utils/validation_functions.dart';
import 'package:skeletons/skeletons.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructionNotebook extends StatefulWidget {
  const InstructionNotebook({
    super.key,
  });

  @override
  State<InstructionNotebook> createState() => _InstructionNotebookState();
}

class _InstructionNotebookState extends State<InstructionNotebook> {
  bool isExpanded = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoading = state.statusExercise == HomeStatus.loading;
        final isDataEmpty =
            state.exerciseDueDateDataList.exerciseDataList.isEmpty &&
                !isLoading;

        final exercisesDueDateToday =
            state.exerciseDueDateToday.exerciseDataList;
        final exercisesDueDate = state.exerciseDueDateDataList.exerciseDataList;
        final exercisesInDay = state.exerciseInDayDataList.exerciseDataList;

        final firstThreeExercisesDueDate =
            exercisesDueDateToday.take(3).toList();

        final lessonsW = List.generate(3, (index) {
          if (index >= firstThreeExercisesDueDate.length) {
            return SizedBox(height: 48.v);
          }

          final lesson = firstThreeExercisesDueDate[index];

          final filePath = firstThreeExercisesDueDate[index].fileBaoBai ?? '';
          final fileName = getFileName(filePath, maxLength: 12);

          return Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: index == 2 ? 0 : 8),
              decoration: BoxDecoration(
                borderRadius: AppRadius.rounded4,
                color: AppColors.grayList,
              ),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    decoration: BoxDecoration(
                        color: AppColors.brand600,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse(
                            'https://${lesson.fileBaoBaiDomain}/${lesson.fileBaoBai}'),
                        mode: LaunchMode.inAppBrowserView,
                      );
                    },
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lesson.subjectName,
                            style: AppTextStyles.semiBold14(
                                color: AppColors.black24),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/paperclip.svg'),
                              const SizedBox(width: 4),
                              Text(
                                fileName,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.normal12(
                                    color: AppColors.brand600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          height: isExpanded ? 580.v : 210.v,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            boxShadow: [homeBoxShadow()],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: AppColors.red,
                        child: SvgPicture.asset(
                          'assets/icons/report.svg',
                          width: 14,
                          height: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Sổ báo bài',
                        style: AppTextStyles.semiBold14(
                          color: AppColors.blueGray800,
                          height: 20 / 14,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (!isExpanded &&
                          bloc.state.datePicked == DateTime.now()) {
                        bloc.add(HomeFetchExercise(isDueDate: false));
                      }
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/icons/${isExpanded ? 'chevron-up-black' : 'chevron-down'}.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: isExpanded
                    ? HomeTabsInstruction(
                        exercisesDueDate: exercisesDueDate,
                        exercisesInDay: exercisesInDay,
                      )
                    : Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.blueGray,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Thứ ${now.weekday + 1}',
                                    style: AppTextStyles.normal14(
                                        color: AppColors.gray600)),
                                const SizedBox(height: 8),
                                Text(DateFormat('dd').format(now),
                                    style: AppTextStyles.custom(
                                      color: AppColors.gray600,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24.fSize,
                                      height: 32 / 24.fSize,
                                    )),
                                const SizedBox(height: 4),
                                Text(
                                  '${DateFormat('MM').format(now)} / ${now.year}',
                                  style: AppTextStyles.normal14(
                                      color: AppColors.gray600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppSkeleton(
                              isLoading: isLoading,
                              skeleton: const InstructrionSkeleton(),
                              child: isDataEmpty
                                  ? const EmptyScreen(text: 'Sổ báo bài trống')
                                  : Column(
                                      children: lessonsW,
                                    ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class InstructrionSkeleton extends StatelessWidget {
  const InstructrionSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SkeletonItem(
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<LessonModel> lessons = [
  LessonModel(
    room: 'Ngoài trời',
    id: 1,
    number: 1,
    name: 'Toán',
    teacherName: 'Nguyễn Minh Nhi',
    description: 'B29: Tính toán với số thập phân',
    advice: 'Chuẩn bị bài trước khi đến lớp',
    timeStart: '7:30',
    timeEnd: '8:15',
    attendance: 'Có mặt',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  LessonModel(
    room: 'P.310',
    id: 2,
    number: 2,
    name: 'Vật lý',
    teacherName: 'Trần Anh Thư',
    description: 'B32: Sự phụ thuộc của điện trở',
    advice: 'Chuẩn bị bài trước khi đến lớp',
    timeStart: '8:15',
    timeEnd: '9:00',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  LessonModel(
    room: 'P.310',
    id: 3,
    number: 3,
    name: 'Hóa học',
    teacherName: 'Võ Hoàng Giang',
    description: 'Kiểm tra 15p',
    advice: 'Chuẩn bị bài trước khi đến lớp',
    timeStart: '9:15',
    timeEnd: '10:00',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  LessonModel(
    room: 'P.310',
    id: 4,
    number: 4,
    teacherName: 'Cao Mỹ Nhân',
    name: 'Hóa học',
    description: 'B30: Nước',
    advice: '',
    timeStart: '10:00',
    timeEnd: '10:45',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
  LessonModel(
    room: 'P.310',
    id: 5,
    number: 5,
    name: 'Tiếng Anh',
    teacherName: 'Lê Trúc My',
    description: 'Kiểm tra 15p',
    advice: '',
    timeStart: '10:45',
    timeEnd: '11:30',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
];
