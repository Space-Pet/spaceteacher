import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/select_date.dart';
import 'package:teacher/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:teacher/screens/register_notebook/register_lesson.dart';
import 'package:repository/repository.dart';
import 'package:teacher/screens/schedule/select_week.dart';

class RegisterNoteBoookScreen extends StatelessWidget {
  const RegisterNoteBoookScreen({Key? key});

  static const routeName = '/register_notebook';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterNotebookBloc(
              appFetchApiRepo: context.read<AppFetchApiRepository>(),
              currentUserBloc: context.read<CurrentUserBloc>(),
            ),
        child: RegisterNoteBookView());
  }
}

class RegisterNoteBookView extends StatelessWidget {
  const RegisterNoteBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterNotebookBloc, RegisterNotebookState>(
      builder: (context, state) {
        final bloc = context.read<RegisterNotebookBloc>();
        final lessonData = state.lessonData;
        final classCn = state.classCn;

        final isLoading = state.status == RegisterNotebookStatus.loading;
        final isEmpty = lessonData.isEmpty && !isLoading;

        // Tạo danh sách các tab từ lessonData
        final listTab = List.generate(lessonData.length, (index) {
          String originalDate = lessonData[index].ngay.day;
          DateTime dateTime = DateFormat('dd-MM-yyyy').parse(originalDate);

          return TabDayOfWeek(
            date: DateFormat('dd-MM').format(dateTime).toString(),
            dayOfW: 'Thứ ${lessonData[index].ngay.date}',
          );
        });

        final lessonListW = List.generate(lessonData.length, (index) {
          final lesson = lessonData[index].dataList;

          return RegisterItem(
            lesson: lesson,
            noBoder: index == lessonData.length - 1,
          );
        });

        // Tính toán initialIndex dựa trên ngày hiện tại
        int initialIndex = 0;
        DateTime currentDate = DateTime.now();
        for (int i = 0; i < lessonData.length; i++) {
          DateTime dateTime =
              DateFormat('dd-MM-yyyy').parse(lessonData[i].ngay.day);
          if (dateTime.isAtSameMomentAs(currentDate) ||
              dateTime.isAfter(currentDate)) {
            initialIndex = i;
            break;
          }
        }

        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenAppBar(
                title: 'Sổ đầu bài',
                canGoback: true,
                onBack: () {
                  Navigator.of(context).pop();
                },
                hasUpdateYear: true,
                iconWidget: DropdownClassSelector(
                  onClass: (value) {
                    if (value == 'Lớp chủ nhiệm') {
                      bloc.add(RegisterSelectDate(
                          datePicked: bloc.state.datePicked));
                    } else if (value == 'Lớp giảng dạy') {
                      bloc.add(RegisterSelectDate(
                          classSelect: 2, datePicked: bloc.state.datePicked));
                    }
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      if (isEmpty)
                        SelectDate(
                          datePicked: bloc.state.datePicked,
                          onDatePicked: (date) {
                            bloc.add(RegisterSelectDate(datePicked: date));
                          },
                        ),
                      if (!isEmpty)
                        WeekSelect(
                          date: bloc.state.datePicked,
                          onDatePicked: (date) {
                            bloc.add(RegisterSelectDate(datePicked: date));
                          },
                        ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: AppSkeleton(
                          isLoading: isLoading,
                          child: isEmpty
                              ? const Center(
                                  child: EmptyScreen(
                                    text: 'Không có dữ liệu',
                                  ),
                                )
                              : DefaultTabController(
                                  length: lessonData.length,
                                  initialIndex: initialIndex,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        padding: const EdgeInsets.all(0),
                                        labelPadding: const EdgeInsets.fromLTRB(
                                            0, 12, 0, 0),
                                        labelColor: AppColors.brand600,
                                        tabAlignment: TabAlignment.fill,
                                        unselectedLabelColor: AppColors.gray500,
                                        dividerColor: AppColors.gray200,
                                        labelStyle: AppTextStyles.semiBold14(
                                            color: AppColors.brand600),
                                        unselectedLabelStyle:
                                            AppTextStyles.normal14(
                                                color: AppColors.gray500),
                                        indicator: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(6),
                                            topRight: Radius.circular(6),
                                          ),
                                          color: AppColors.gray100,
                                        ),
                                        tabs: listTab,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: TabBarView(
                                            children: lessonListW,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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

class DropdownClassSelector extends StatefulWidget {
  DropdownClassSelector({
    required this.onClass,
  });
  final Function(String?) onClass;
  @override
  _DropdownClassSelectorState createState() => _DropdownClassSelectorState();
}

class _DropdownClassSelectorState extends State<DropdownClassSelector> {
  String selectedClass = 'Lớp chủ nhiệm';

  @override
  Widget build(BuildContext context) {
    List<String> classOptions = [
      'Lớp chủ nhiệm',
      'Lớp giảng dạy',
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButton<String>(
        padding: EdgeInsets.zero,
        style: AppTextStyles.bold14(color: AppColors.black),
        value: selectedClass,
        onChanged: (newValue) {
          setState(() {
            selectedClass = newValue ?? '';
          });
          widget.onClass(newValue);
        },
        items: classOptions.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Text(
                option,
                style: AppTextStyles.normal14(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TabDayOfWeek extends StatelessWidget {
  const TabDayOfWeek({
    Key? key,
    required this.dayOfW,
    required this.date,
  }) : super(key: key);

  final String dayOfW;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Align(
        child: Column(
          children: [
            Text(dayOfW,
                style: AppTextStyles.semiBold14(color: AppColors.brand600)),
            const SizedBox(height: 4),
            Text(
              date,
              style: AppTextStyles.normal14(),
            ),
          ],
        ),
      ),
    );
  }
}
