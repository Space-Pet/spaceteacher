import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/weekly_tabs.dart';
import 'package:iportal2/screens/week_schedule/bloc/week_schedule_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

class WeekScheduleScreen extends StatelessWidget {
  const WeekScheduleScreen({super.key, this.date});

  static const routeName = '/week-schedule';
  final String? date;
  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final weekScheduleBloc = WeekScheduleBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);
    weekScheduleBloc.add(GetWeekSchedule(
        txtDate: date != null
            ? date ?? ''
            : DateFormat('dd-MM-yyy').format(DateTime.now()).toString()));
    return BlocProvider.value(
      value: weekScheduleBloc,
      child: WeekScheduleView(),
    );
  }
}

class WeekScheduleView extends StatelessWidget {
  const WeekScheduleView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekScheduleBloc, WeekScheduleState>(
      builder: (context, state) {
        final weekData = state.weekSchedule;
        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenAppBar(
                title: 'Kế hoạch tuần',
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 26, 16, 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state.weekScheduleStatus == WeekScheduleStatus.init)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (state.weekScheduleStatus ==
                          WeekScheduleStatus.success)
                        WeekSelectWidget(
                          weekSchedule: weekData ?? null,
                        ),
                      if (weekData != null &&
                          weekData.data.mainPlan!.isNotEmpty &&
                          state.weekScheduleStatus ==
                              WeekScheduleStatus.success)
                        WeeklyTopic(weekSchedule: weekData),
                      const SizedBox(height: 16),
                      if (weekData != null &&
                          weekData.data.detailPlan!.isNotEmpty &&
                          state.weekScheduleStatus ==
                              WeekScheduleStatus.success)
                        Expanded(
                          child: WeeklyTabs(
                            lessons: weekData.data.detailPlan,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WeeklyTopic extends StatelessWidget {
  const WeeklyTopic({super.key, this.weekSchedule});
  final WeekSchedule? weekSchedule;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(1.00, -0.06),
          end: Alignment(-1, 0.06),
          colors: [Color(0xFFF0F9FF), Color(0xFFE4F4FF)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: const Color(0xFFDFF2FE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
              child: SvgPicture.asset(
                'assets/icons/topic_week.svg',
              )),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weekSchedule?.data.mainPlan?.isNotEmpty ?? false
                      ? weekSchedule!.data.mainPlan!.first.mainPlanTitle ?? ''
                      : '',
                  style: AppTextStyles.normal12(
                    color: AppColors.gray400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weekSchedule?.data.mainPlan?.isNotEmpty ?? false
                      ? weekSchedule!.data.mainPlan!.first.mainPlanBody ?? ''
                      : '',
                  style: AppTextStyles.normal12(
                      color: AppColors.black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WeekSelectWidget extends StatefulWidget {
  const WeekSelectWidget({super.key, this.weekSchedule});
  final WeekSchedule? weekSchedule;

  @override
  State<WeekSelectWidget> createState() => _WeekSelectWidgetState();
}

class _WeekSelectWidgetState extends State<WeekSelectWidget> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  int _currentWeek = 1;
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(DateTime.now());
  }

  void _goBackOneWeek() {
    setState(() {
      if (_currentWeek >= 1) {
        now = now.subtract(const Duration(days: 7));
        _currentWeek--;
      } else {
        return;
      }
    });
  }

  void _goForwardOneWeek() {
    setState(() {
      _currentWeek++;
      now = now.add(const Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 4));

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: const BoxDecoration(
            color: AppColors.gray100,
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<WeekScheduleBloc>().add(GetWeekSchedule(
                      txtDate: widget.weekSchedule?.txtPreWeek ?? ''));
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: AppColors.gray400,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      helpText: 'Chọn ngày',
                      cancelText: 'Trở về',
                      confirmText: 'Xong',
                      initialDate: formatDate.parse(datePicked),
                      firstDate: DateTime(now.year, now.month, now.day - 7),
                      lastDate: DateTime(now.year, now.month, now.day + 7),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppColors.brand600,
                              secondary: AppColors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyy').format(pickedDate);
                      setState(() {
                        datePicked = formattedDate;
                        print('object: $datePicked');
                        context
                            .read<WeekScheduleBloc>()
                            .add(GetWeekSchedule(txtDate: datePicked));
                      });
                    } else {}
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tuần ${widget.weekSchedule?.txtWeek} ',
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600)),
                      Text(
                        '(${widget.weekSchedule?.txtBeginDay} - ${widget.weekSchedule?.txtEndDay})',
                        style: AppTextStyles.normal14(color: AppColors.gray500),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<WeekScheduleBloc>().add(GetWeekSchedule(
                      txtDate: widget.weekSchedule?.txtNextWeek ?? ''));
                },
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: AppColors.gray400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final List<LessonModel> weeklyProjects = [
  LessonModel(
    room: 'P.310',
    id: 1,
    number: 1,
    name: 'Đón trẻ và điểm danh',
    teacherName: 'Nguyễn Minh Nhi',
    description: 'Cô đón trẻ từ Quý Phụ Huynh và tiến hành điểm danh',
    advice: 'Học sinh chuẩn bị bài kỹ trước khi đến lớp.',
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
    name: 'Ăn sáng',
    teacherName: 'Trần Anh Thư',
    description: '',
    advice: '',
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
    name: 'Thực hành mầm non',
    teacherName: 'Võ Hoàng Giang',
    description:
        'Cô hướng dẫn trẻ thực hành vệ sinh cá nhân, học cách tự phục vụ',
    advice: 'Học sinh chuẩn bị bài kỹ trước khi đến lớp.',
    timeStart: '9:15',
    timeEnd: '10:00',
    attendance: 'Vắng có phép',
    fileUrl: '',
  ),
  LessonModel(
    room: 'P.310',
    id: 4,
    number: 4,
    teacherName: 'Cao Mỹ Nhân',
    name: 'Hoạt động vui chơi',
    description:
        'Cô dạy trẻ chơi trò chơi vận động, trò chơi xã hội, trò chơi xây dựng',
    advice: '',
    timeStart: '10:00',
    timeEnd: '10:45',
    attendance: 'Vắng có phép',
    fileUrl: '',
  ),
  LessonModel(
    room: 'P.310',
    id: 5,
    number: 5,
    name: 'Hoạt động ngoài trời',
    teacherName: 'Lê Trúc My',
    description:
        'Cô cùng trẻ vui chơi ngoài trời, trò chơi vận động, trò chơi xã hội',
    advice: '',
    timeStart: '10:45',
    timeEnd: '11:30',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
];
