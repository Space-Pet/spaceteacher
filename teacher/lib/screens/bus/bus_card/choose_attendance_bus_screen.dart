import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/bus/attendance_bus.dart';
import 'package:teacher/screens/bus/bloc/bus_bloc.dart';
import 'package:teacher/screens/bus/list_attendance_bus_screen.dart';
import 'package:teacher/screens/bus/widgets/row_content.dart';

class ChooseAttendanceBusScreen extends StatelessWidget {
  const ChooseAttendanceBusScreen(
      {super.key, required this.busScheduleTeacher});
  final BusScheduleTeacher busScheduleTeacher;
  static const routeName = '/chooseAttendanceBus';
  @override
  Widget build(BuildContext context) {
    final currentUserBloc = context.read<CurrentUserBloc>();
    final appFetchApiRepository = context.read<AppFetchApiRepository>();
    final busBloc = BusBloc(
        userRepository: context.read<UserRepository>(),
        appFetchApiRepository: appFetchApiRepository,
        currentUserBloc: currentUserBloc);
    busBloc.add(DetailBus(idBus: busScheduleTeacher.id ?? 0));
    return BlocProvider.value(
      value: busBloc,
      child: ChooseAttendanceBusView(
        busScheduleTeacher: busScheduleTeacher,
      ),
    );
  }
}

class ChooseAttendanceBusView extends StatefulWidget {
  const ChooseAttendanceBusView({super.key, required this.busScheduleTeacher});
  final BusScheduleTeacher busScheduleTeacher;
  @override
  State<ChooseAttendanceBusView> createState() =>
      _ChooseAttendanceBusViewState();
}

class _ChooseAttendanceBusViewState extends State<ChooseAttendanceBusView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String formatTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('HH:mm').format(parsedDate);
  }

  String formatTimeDay(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusBloc, BusState>(builder: (context, state) {
      final isLoading = state.status == BusStatus.loading;
      final detailBus = state.detailBusSchedule;
      String typeSchudule = '';
      if (detailBus?.scheduleType == 'Trả') {
        typeSchudule = 'xuống';
      } else {
        typeSchudule = 'lên';
      }
      return Scaffold(
        body: BackGroundContainer(
          child: Column(
            children: [
              ScreenAppBar(
                title: 'Điểm danh đi xe',
                canGoback: true,
                onBack: () {
                  context.pop();
                },
                hasUpdateYear: true,
                iconWidget: Assets.icons.history.svg(),
                onOpenIcon: () {
                  context.push(const ListAttendanceBusScreen());
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppRadius.rounded20,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: AppSkeleton(
                      isLoading: isLoading,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: AppColors.gray100,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                labelColor: AppColors.brand600,
                                dividerColor: Colors.transparent,
                                labelPadding: EdgeInsets.zero,
                                indicatorPadding:
                                    const EdgeInsets.only(top: -3.5),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelStyle: AppTextStyles.semiBold16(
                                  color: AppColors.brand600,
                                ),
                                onTap: (value) {
                                  setState(() {
                                    _tabController.index = 0;
                                  });
                                },
                                unselectedLabelStyle: AppTextStyles.semiBold14(
                                    color: AppColors.brand600),
                                indicator: const BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                tabs: [
                                  Tab(
                                    child: Align(
                                      child: Text(
                                        '${detailBus?.scheduleType == 'Trả' ? 'Xuống' : 'Lên'} xe',
                                      ),
                                    ),
                                  ),
                                  const Tab(
                                    child: Align(
                                      child: Text(''),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppColors
                                                      .observationStatusSuccessText,
                                                ),
                                                child: Text(
                                                  'Giờ $typeSchudule xe - ${formatTime(detailBus?.departureTime ?? '2024-04-23 04:00:00')}',
                                                  style: AppTextStyles.normal12(
                                                    color: AppColors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          RowContentBus(
                                            title: 'Tuyến',
                                            content: detailBus?.route?.name ?? '',
                                            isShowDottedLine: true,
                                            color: AppColors.blue600,
                                          ),
                                          RowContentBus(
                                            title: 'Ngày',
                                            content: formatTimeDay(
                                                detailBus?.departureTime ??
                                                    '2024-04-23 04:00:00'),
                                            isShowDottedLine: true,
                                            color: AppColors.blue600,
                                          ),
                                          RowContentBus(
                                            title: 'Biển số xe',
                                            content: detailBus
                                                    ?.driverInfo?.numberPlate ??
                                                '',
                                            isShowDottedLine: true,
                                          ),
                                          RowContentBus(
                                            title: 'Tài xế',
                                            content: detailBus
                                                    ?.driverInfo?.driverName ??
                                                '',
                                            isShowDottedLine: true,
                                          ),
                                          RowContentBus(
                                            title: 'Bảo mẫu',
                                            content:
                                                detailBus?.teacher?.teacherName ??
                                                    '',
                                            isShowDottedLine: true,
                                          ),
                                          RowContentBus(
                                            title: 'Tổng số học sinh cần đón',
                                            content:
                                                detailBus?.total.toString() ?? '',
                                            isShowDottedLine: true,
                                            color: AppColors.blue600,
                                          ),
                                          const RowContentBus(
                                            title: 'Điểm đón',
                                            content: '14 Trần Hưng Đạo, Vũng Tàu',
                                            isShowDottedLine: true,
                                          ),
                                          // RowContentBus(
                                          //   title: 'Tổng số trạm dừng',
                                          //   content: widget
                                          //       .busScheduleTeacher.totalBusStop
                                          //       .toString(),
                                          //   isShowDottedLine: true,
                                          // ),
                                          RowContentBus(
                                            title:
                                                'Thời gian dự kiến đến điểm đón',
                                            content: formatTime(
                                                detailBus?.endTime ??
                                                    '2024-04-23 04:00:00'),
                                            isShowDottedLine: true,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  width: 1,
                                                  color: AppColors.gray200,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '${(detailBus?.total ?? 0) - (detailBus?.absence?.count ?? 0)}',
                                                          style: AppTextStyles
                                                              .normal18(
                                                            color: AppColors
                                                                .green600,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Có mặt',
                                                          style: AppTextStyles
                                                              .normal14(
                                                            color:
                                                                AppColors.gray500,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 1,
                                                    height: 20,
                                                    color: AppColors.gray300,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          detailBus
                                                                  ?.absence?.count
                                                                  .toString() ??
                                                              '0',
                                                          style: AppTextStyles
                                                              .normal18(
                                                            color:
                                                                AppColors.red700,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Vắng',
                                                          style: AppTextStyles
                                                              .normal14(
                                                            color:
                                                                AppColors.gray500,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: detailBus?.absence?.count,
                                            itemBuilder: (context, index) {
                                              final items = detailBus
                                                  ?.absence?.pupils?[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 16),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          items?.fullName ?? '',
                                                          style: AppTextStyles
                                                              .normal14(
                                                            color: AppColors
                                                                .brand600,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          items?.id.toString() ??
                                                              '',
                                                          style: AppTextStyles
                                                              .normal14(
                                                            color: AppColors
                                                                .secondary,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Assets.icons.absent.svg()
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(6),
                    backgroundColor: AppColors.red900,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.qrCode.svg(
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Điểm danh QR',
                          style: AppTextStyles.semiBold14(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push(AttendanceBusScreen(
                      busScheduleTeacher: widget.busScheduleTeacher,
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color?>(
                      AppColors.white,
                    ),
                    side: WidgetStateProperty.all<BorderSide>(
                      const BorderSide(color: AppColors.gray300),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11, bottom: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.checkAbsent.svg(
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              AppColors.redMenu, BlendMode.srcIn),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Điểm danh',
                          style:
                              AppTextStyles.semiBold14(color: AppColors.redMenu),
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
    });
  }
}
