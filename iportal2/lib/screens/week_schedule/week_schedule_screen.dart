import 'package:core/data/models/models.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/app_skeleton.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/empty_screen.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/weekly_tabs.dart';
import 'package:iportal2/screens/week_schedule/bloc/week_schedule_bloc.dart';
import 'package:repository/repository.dart';
import 'package:skeletons/skeletons.dart';

class WeekScheduleScreen extends StatefulWidget {
  const WeekScheduleScreen({super.key, this.date});

  static const routeName = '/week-schedule';
  final String? date;

  @override
  State<WeekScheduleScreen> createState() => _WeekScheduleScreenState();
}

class _WeekScheduleScreenState extends State<WeekScheduleScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userRepository = context.read<UserRepository>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final weekScheduleBloc = WeekScheduleBloc(
        appFetchApiRepo: appFetchApiRepository,
        currentUserBloc: context.read<CurrentUserBloc>(),
        userRepository: userRepository);
    weekScheduleBloc.add(GetWeekSchedule(
        date: DateTime.now(),
        txtDate: widget.date != null
            ? widget.date ?? ''
            : DateFormat('dd-MM-yyy').format(DateTime.now()).toString()));
    return BlocProvider.value(
      value: weekScheduleBloc,
      child: const WeekScheduleView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WeekScheduleView extends StatelessWidget {
  const WeekScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekScheduleBloc, WeekScheduleState>(
      builder: (context, state) {
        final weekData = state.weekSchedule;
        final isLoading = state.weekScheduleStatus == WeekScheduleStatus.init;
        final date = state.date;

        return BackGroundContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenAppBar(
                title: 'Kế hoạch tuần',
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.roundedTop28,
                  ),
                  child: ClipRRect(
                    borderRadius: AppRadius.rounded10,
                    child: AppSkeleton(
                        skeleton: SizedBox(
                            height: 500,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: 5,
                              itemBuilder: (context, index) => Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 0, 12),
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
                        child: Column(
                          children: [
                            WeekSelectWidget(
                              date: date ?? DateTime.now(),
                              weekSchedule: weekData,
                            ),
                            if (weekData != null &&
                                weekData.data.mainPlan!.isNotEmpty &&
                                state.weekScheduleStatus ==
                                    WeekScheduleStatus.success)
                              WeeklyTopic(weekSchedule: weekData),
                            const SizedBox(height: 8),
                            if (weekData != null &&
                                weekData.data.detailPlan!.isNotEmpty &&
                                state.weekScheduleStatus ==
                                    WeekScheduleStatus.success)
                              Expanded(
                                child: WeeklyTabs(
                                  date: date ?? DateTime.now(),
                                  lessons: weekData.data.detailPlan,
                                ),
                              ),
                            if (weekData == null ||
                                weekData.data.detailPlan!.isEmpty)
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 200),
                                  child: Center(
                                    child: EmptyScreen(
                                        text: 'Bạn chưa có kế hoạch tuần'),
                                  ),
                                ),
                              )
                          ],
                        )),
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
      margin: const EdgeInsets.only(top: 8),
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
                // Text(
                //   weekSchedule?.data.mainPlan?.isNotEmpty ?? false
                //       ? weekSchedule!.data.mainPlan!.first.mainPlanTitle ?? ''
                //       : '',
                //   style: AppTextStyles.normal12(color: AppColors.gray400),
                // ),
                // Text(
                //   'Chủ đề',
                //   style: AppTextStyles.normal12(color: AppColors.gray400),
                // ),
                const SizedBox(height: 4),
                Text(
                  weekSchedule?.data.mainPlan?.isNotEmpty ?? false
                      ? weekSchedule!.data.mainPlan!.first.mainPlanBody ?? ''
                      : '',
                  style: AppTextStyles.normal12(fontWeight: FontWeight.w700),
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
  const WeekSelectWidget({super.key, this.weekSchedule, required this.date});
  final WeekSchedule? weekSchedule;
  final DateTime date;
  @override
  State<WeekSelectWidget> createState() => _WeekSelectWidgetState();
}

class _WeekSelectWidgetState extends State<WeekSelectWidget> {
  DateTime now = DateTime.now();

  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  late String datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = formatDate.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  date: DateTime.now(),
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
                  String formattedDate =
                      DateFormat('dd-MM-yyy').format(pickedDate);
                  setState(() {
                    datePicked = formattedDate;
                    context.read<WeekScheduleBloc>().add(
                        GetWeekSchedule(txtDate: datePicked, date: pickedDate));
                  });
                } else {}
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tuần ${widget.weekSchedule?.txtWeek} ',
                      style:
                          AppTextStyles.semiBold14(color: AppColors.brand600)),
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
                  date: DateTime.now(),
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
    );
  }
}
