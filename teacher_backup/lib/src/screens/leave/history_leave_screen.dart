import 'package:core/core.dart';
import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/app_skeleton.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/leave_repository/leave_repository.dart';
import 'package:teacher/src/screens/leave/bloc/leave_bloc.dart';
import 'package:teacher/src/screens/leave/widget/application_item.dart';
import 'package:teacher/src/utils/extension_context.dart';

class HistoryLeaveScreen extends StatelessWidget {
  const HistoryLeaveScreen({super.key, required this.userInfo});
  static const routeName = '/history-leave';
  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    final leaveRepository = Injection.get<LeaveRepository>();
    final leaveBloc = LeaveBloc(leaveRepositoryl: leaveRepository);
    leaveBloc.add(GetHistoryLeave(
      selectedDate: DateTime.now(),
      userInfo: userInfo,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    ));
    return BlocProvider.value(
      value: leaveBloc,
      child: HistoryLeaveView(userInfo: userInfo),
    );
  }
}

class HistoryLeaveView extends StatelessWidget {
  const HistoryLeaveView({super.key, required this.userInfo});
  final UserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaveBloc, LeaveState>(builder: (context, state) {
      final isLoading = state.leaveStatus == LeaveStatus.init;
      final leave = state.leaveData;
      final selectedDate = state.selectedDate;
      return Scaffold(
        body: BackGroundContainer(
            child: Column(
          children: [
            ScreenAppBar(
              title: 'Nghỉ phép',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              decoration: const BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SelectDate(
                    date: selectedDate,
                    userInfo: userInfo,
                  ),
                  Expanded(
                    child: AppSkeleton(
                      skeleton: Container(
                          color: Colors.white,
                          height: double.infinity,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            itemCount: 5,
                            itemBuilder: (context, index) => Container(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: index == 4
                                      ? BorderSide.none
                                      : const BorderSide(
                                          color: AppColors.gray300),
                                ),
                              ),
                              child: SkeletonItem(
                                  child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SkeletonParagraph(
                                          style: SkeletonParagraphStyle(
                                              lineStyle: SkeletonLineStyle(
                                            randomLength: true,
                                            height: 10,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          )),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                            ),
                          )),
                      isLoading: isLoading,
                      child: Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 8),
                            itemCount: leave?.length,
                            itemBuilder: (context, index) {
                              final item = leave?[index];
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: index == 0 ? 0 : 8),
                                child: ApplicationItem(
                                  application: item,
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        )),
      );
    });
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, required this.date, required this.userInfo});
  final DateTime date;
  final UserInfo userInfo;
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
          initialDate: widget.date,
          firstDate: DateTime(now.year - 3, now.month),
          lastDate: DateTime(now.year + 1, now.month),
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
            context.read<LeaveBloc>().add(GetHistoryLeave(
                  date: DateFormat('yyyy-MM-dd').format(pickedDate),
                  userInfo: widget.userInfo,
                  selectedDate: pickedDate,
                ));
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
