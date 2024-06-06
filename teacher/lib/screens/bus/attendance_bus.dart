import 'package:core/core.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/bus/bloc/bus_bloc.dart';
import 'package:teacher/screens/bus/widgets/row_content.dart';

class AttendanceBusScreen extends StatelessWidget {
  const AttendanceBusScreen({super.key, required this.busScheduleTeacher});
  final BusScheduleTeacher? busScheduleTeacher;
  @override
  Widget build(BuildContext context) {
    final busBloc = BusBloc(
      appFetchApiRepository: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: context.read<UserRepository>(),
    );
    busBloc.add(GetListAttendanceBus(busId: busScheduleTeacher?.id ?? 0));
    return BlocProvider.value(
      value: busBloc,
      child: BlocListener<BusBloc, BusState>(
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
        listener: (context, state) {
          if (state.status == BusStatus.loadingPost) {
            LoadingDialog.show(context);
          } else if (state.status == BusStatus.successPost) {
            LoadingDialog.hide(context);
            busBloc
                .add(GetListAttendanceBus(busId: busScheduleTeacher?.id ?? 0));
          } else if (state.status == BusStatus.failure) {
            LoadingDialog.hide(context);
            Fluttertoast.showToast(
                msg: state.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.black,
                textColor: AppColors.white);
          } else if (state.status == BusStatus.successGetListAttendance) {}
        },
        child: const AttendanceBusView(),
      ),
    );
  }
}

class AttendanceBusView extends StatefulWidget {
  const AttendanceBusView({
    super.key,
  });

  @override
  _AttendanceBusViewState createState() => _AttendanceBusViewState();
}

class _AttendanceBusViewState extends State<AttendanceBusView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<BusBloc, BusState>(builder: (context, state) {
      final isLoading = state.status == BusStatus.loading;
      final pupilToDisplay = state.listAttendanceBus;
      final type = state.type;
      return BackGroundContainer(
        child: Column(
          children: [
            ScreenAppBar(
              title: 'Điểm danh (Trạm ${pupilToDisplay?.routeName ?? ''})',
              canGoback: true,
              onBack: () {
                context.pop();
              },
              hasUpdateYear: true,
              icon: 'assets/icons/history.svg',
              onOpenIcon: () {},
            ),
            Expanded(
              child: Container(
                color: AppColors.white,
                child: AppSkeleton(
                  isLoading: isLoading,
                  child: Column(
                    mainAxisAlignment: pupilToDisplay == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      if (pupilToDisplay == null)
                        const SizedBox(
                            width: double.infinity,
                            child: EmptyScreen(text: 'Không còn học sinh')),
                      if (pupilToDisplay != null)
                        Column(
                          children: [
                            Container(
                              height: screenHeight / 2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      pupilToDisplay.thumbnail.web),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pupilToDisplay.pupilName ?? '',
                                        style: AppTextStyles.normal18(
                                          color: AppColors.brand600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          pupilToDisplay.pupliId.toString() ??
                                              '',
                                          style: AppTextStyles.normal14(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.brand600,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Assets.icons.callBus.svg(),
                                        Text(
                                          pupilToDisplay.phoneNumber,
                                          style: AppTextStyles.normal14(
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const DottedLine(
                              dashLength: 2,
                              dashColor: AppColors.gray300,
                            ),
                            RowContentBus(
                              title: 'Điểm đón',
                              content: pupilToDisplay.busStopAddress ?? '',
                              isShowDottedLine: false,
                            ),
                            RowContentBus(
                              title: 'Thời gian dự kiến đến điểm đón',
                              content: pupilToDisplay.timeEstimate ?? '',
                              isShowDottedLine: false,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<BusBloc>()
                                        .add(PostUpdateAbsentBus(
                                          attendanceId: pupilToDisplay.id ?? 0,
                                          pupilId: pupilToDisplay.pupliId ?? 0,
                                          scheduleId:
                                              pupilToDisplay.scheduleId ?? 0,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: AppColors.redMenu,
                                        width: 1,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 12),
                                    child: Center(
                                      child: Text(
                                        'Vắng',
                                        style: AppTextStyles.normal16(
                                          color: AppColors.redMenu,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24),
                                  child: GestureDetector(
                                    onTap: () {
                                      context
                                          .read<BusBloc>()
                                          .add(PostTakeAttendanceOfEachStudent(
                                            attendanceId:
                                                pupilToDisplay.id ?? 0,
                                            pupilId:
                                                pupilToDisplay.pupliId ?? 0,
                                            scheduleId:
                                                pupilToDisplay.scheduleId ?? 0,
                                            type: type,
                                          ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.green100,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 12),
                                      child: Center(
                                        child: Text(
                                          'Có mặt',
                                          style: AppTextStyles.normal16(
                                            color: AppColors.green600,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
