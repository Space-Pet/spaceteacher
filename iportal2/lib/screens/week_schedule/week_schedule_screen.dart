import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/home/models/lesson_model.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/tab_instruction.dart';

class WeekScheduleScreen extends StatelessWidget {
  const WeekScheduleScreen({super.key});

  static const routeName = '/week-schedule';

  @override
  Widget build(BuildContext context) {
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
                children: [
                  const WeekSelectWidget(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabInstruction(
                      lessons: weeklyProjects,
                      isTimeTableView: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeekSelectWidget extends StatefulWidget {
  const WeekSelectWidget({super.key});

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
                onTap: _goBackOneWeek,
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
                      String formattedDate = formatDate.format(pickedDate);
                      setState(() {
                        datePicked = formattedDate;
                      });
                    } else {}
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Tuần $_currentWeek ',
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600)),
                      Text(
                        '(${DateFormat('dd/M/yyyy').format(startOfWeek)} -  ${DateFormat('dd/M/yyyy').format(endOfWeek)})',
                        style: AppTextStyles.normal14(color: AppColors.gray500),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _goForwardOneWeek,
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

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          String formattedDate = formatDate.format(pickedDate);
          setState(() {
            datePicked = formattedDate;
          });
        } else {}
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.gray300),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: AppColors.gray9000c,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 20,
                    color: AppColors.gray500,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        datePicked,
                        style: AppTextStyles.normal16(color: AppColors.gray500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 24,
              color: AppColors.gray900,
            ),
          ],
        ),
      ),
    );
  }
}

final List<LessonModel> weeklyProjects = [
  LessonModel(
    room: 'P.310',
    id: 1,
    number: 1,
    name: 'Toán',
    teacherName: 'Nguyễn Minh Nhi',
    teacherAva:
        'https://cdn3.iconfinder.com/data/icons/avatar-91/130/avatar__girl__teacher__female__women-512.png',
    description: 'B29: Tính toán với số thập phân',
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
    name: 'Vật lý',
    teacherName: 'Trần Anh Thư',
    teacherAva:
        'https://www.shutterstock.com/image-vector/female-character-portrait-smiling-young-260nw-312909497.jpg',
    description: 'B32: Sự phụ thuộc của điện trở',
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
    name: 'Hóa học',
    teacherName: 'Võ Hoàng Giang',
    teacherAva:
        'https://c8.alamy.com/comp/T5EY8E/female-teacher-avatar-character-vector-illustration-design-T5EY8E.jpg',
    description: 'Kiểm tra 15p',
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
    teacherAva:
        'https://t3.ftcdn.net/jpg/02/00/91/10/360_F_200911053_4ygtfQ75mb72sGYeHDfyl2JF4aiTtT0n.jpg',
    name: 'Hóa học',
    description: 'B30: Nước',
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
    name: 'Tiếng Anh',
    teacherName: 'Lê Trúc My',
    teacherAva:
        'https://thumbs.dreamstime.com/z/female-teacher-avatar-character-female-teacher-avatar-character-vector-illustration-design-145742021.jpg',
    description: 'Kiểm tra 15p',
    advice: '',
    timeStart: '10:45',
    timeEnd: '11:30',
    attendance: 'Vắng có phép',
    fileUrl:
        'https://aegona-my.sharepoint.com/:w:/p/phu_nguyen/EQeJxQVUN65Fl5MRI_dRo9IB6nFgBG7HROx4-ICPvy700A?e=f2MfU6',
  ),
];
