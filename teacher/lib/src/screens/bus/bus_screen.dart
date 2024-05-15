import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:teacher/components/app_bar/app_bar.dart';

import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/date_picker_horizontal.dart';
import 'package:teacher/components/empty_screen.dart';

import 'package:teacher/repository/bus_repository/bus_repositories.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/screens/bus/bloc/bus_bloc.dart';
import 'package:teacher/src/screens/bus/bus_card/card_bus_item.dart';
import 'package:teacher/src/utils/extension_context.dart';

class BusScreen extends StatelessWidget {
  const BusScreen({super.key});
  static const routeName = '/bus';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BusBloc(busRepository: Injection.get<BusRepository>()),
      child: const BusView(),
    );
  }
}

class BusView extends StatefulWidget {
  const BusView({super.key});

  @override
  State<BusView> createState() => _BusViewState();
}

class _BusViewState extends State<BusView> {
  final _controller = RefreshController();
  final _pageController = PageController();
  DateTime _selectedDay = DateTime.now();
  String _endDate = '';

  @override
  void initState() {
    _endDate = DateFormat('dd/MM')
        .format(_selectedDay.copyWith(month: _selectedDay.month + 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              title: 'Lịch xe đưa rước',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                      duration: Durations.medium4,
                                      curve: Curves.linear);
                                },
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Text(
                                'Tuần ${_selectedDay.weekOfYear} '
                                '(${DateFormat('dd/MM').format(_selectedDay)} - $_endDate)',
                                style: AppTextStyles.bold16(),
                              ),
                              IconButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                      duration: Durations.medium4,
                                      curve: Curves.linear);
                                },
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                          DatePickerHorizontal(
                            pageController: _pageController,
                            selectedDay: _selectedDay,
                            changeDay: (value) => setState(() {
                              _selectedDay = value;
                              _endDate = DateFormat('dd/MM').format(_selectedDay
                                  .copyWith(month: _selectedDay.month + 1));

                              context.read<BusBloc>().add(
                                    BusFetchedSchedules(
                                      startDate: DateFormat('yyyy-MM-dd')
                                          .format(_selectedDay),
                                      endDate: DateFormat('yyyy-MM-dd').format(
                                          _selectedDay.copyWith(
                                              month: _selectedDay.month + 1)),
                                      schoolBrand: 'ischool',
                                      schoolId: 104,
                                    ),
                                  );
                            }),
                            enableWeeknumberText: false,
                            weeknumberColor: AppColors.blueForgorPassword,
                            weeknumberTextColor: AppColors.gray400,
                            backgroundColor: AppColors.gray200,
                            weekdayTextColor: const Color(0xFF8A8A8A),
                            digitsColor: AppColors.gray400,
                            selectedDigitBackgroundColor:
                                AppColors.blueForgorPassword,
                            weekdays: const [
                              "T2",
                              "T3",
                              "T4",
                              "T5",
                              "T6",
                              "T7",
                              "CN"
                            ],
                            daysInWeek: 7,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocBuilder<BusBloc, BusState>(
                        builder: (context, state) {
                          final busSchedules = state.busSchedules;
                          final isLoading = state.status == BusStatus.loading;
                          final isEmptyData =
                              busSchedules.isEmpty && !isLoading;

                          return SmartRefresher(
                            controller: _controller,
                            onRefresh: () async {},
                            child: Stack(
                              children: [
                                ListView(),
                                isEmptyData
                                    ? const Center(
                                        child: EmptyScreen(
                                            text: 'Chưa có dữ liệu'))
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        cacheExtent: 1000,
                                        itemCount: busSchedules.length,
                                        itemBuilder: (context, index) {
                                          return CardBusItem(
                                            busSchedule: busSchedules[index],
                                          );
                                        },
                                      ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key, required this.onDateChanged});

  final Function(DateTime date) onDateChanged;

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
          widget.onDateChanged(pickedDate);
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
            side: const BorderSide(color: AppColors.blueGray100),
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
