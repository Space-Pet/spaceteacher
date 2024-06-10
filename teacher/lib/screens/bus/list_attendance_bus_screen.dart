import 'package:core/core.dart';
import 'package:core/data/models/list_attendance_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:teacher/resources/assets.gen.dart';

import 'package:flutter/cupertino.dart';
import 'package:repository/repository.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/authentication/utilites/dialog_utils.dart';
import 'package:teacher/screens/bus/bloc/bus_bloc.dart';
import 'package:teacher/screens/bus/widgets/select_date.dart';

class ListAttendanceBusScreen extends StatefulWidget {
  const ListAttendanceBusScreen({
    super.key,
    required this.busScheduleTeacher,
  });
  final BusScheduleTeacher? busScheduleTeacher;

  @override
  State<ListAttendanceBusScreen> createState() =>
      _ListAttendanceBusScreenState();
}

class _ListAttendanceBusScreenState extends State<ListAttendanceBusScreen> {
  late List<Pupils> newList = [];
  void checkAttendance({required List<Pupils> newAttendance}) {
    newList = newAttendance;
  }

  @override
  Widget build(BuildContext context) {
    final busBloc = BusBloc(
      appFetchApiRepository: context.read<AppFetchApiRepository>(),
      currentUserBloc: context.read<CurrentUserBloc>(),
      userRepository: context.read<UserRepository>(),
    );
    busBloc.add(GetEditAttendance(busId: widget.busScheduleTeacher?.id ?? 0));

    return BlocProvider.value(
        value: busBloc,
        child: BlocListener<BusBloc, BusState>(
          listener: (context, state) {
            if (state.status == BusStatus.loadingPost) {
              LoadingDialog.show(context);
            } else if (state.status == BusStatus.successPost) {
              context
                  .read<BusBloc>()
                  .add(DetailBus(idBus: widget.busScheduleTeacher?.id ?? 0));
              context.read<BusBloc>().add(BusChangedDate(
                  date: state.selectedDate.yyyyMMdd,
                  selectDate: state.selectedDate));

              LoadingDialog.hide(context);
            } else if (state.status == BusStatus.failure) {
              LoadingDialog.hide(context);
              Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: AppColors.black,
                  textColor: AppColors.white);
            }
          },
          child: BlocBuilder<BusBloc, BusState>(builder: (context, state) {
            final detailTeacher = state.userData;
            final isLoading = state.status == BusStatus.loading;
            final dateTime = state.selectedDate;
            late List<Pupils> listAttendance = state.editAttendance;
            return BackGroundContainer(
              child: Column(
                children: [
                  ScreenAppBar(
                    title: 'Xem lại điểm danh',
                    canGoback: true,
                    onBack: () {
                      context.pop();
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: AppSkeleton(
                        isLoading: isLoading,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(detailTeacher
                                              .info.urlImage.mobile)),
                                      shape: BoxShape.circle,
                                      color: AppColors.white,
                                      border: Border.all(
                                          color: AppColors.black, width: 1)),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detailTeacher.info.fullName,
                                      style: AppTextStyles.semiBold12(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    Text(
                                      detailTeacher.info.mainSubject,
                                      style: AppTextStyles.normal12(
                                        color: AppColors.black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: SelectDate(
                                selectDate: dateTime,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      Assets.images.ateendancePink.provider(),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              widget.busScheduleTeacher
                                                      ?.scheduleType ??
                                                  '',
                                              style: AppTextStyles.normal14(
                                                color: AppColors.brand600,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
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
                                                (newList.isEmpty
                                                        ? listAttendance
                                                        : newList)
                                                    .where((attendance) =>
                                                        attendance.attendance ==
                                                        1)
                                                    .toList()
                                                    .length
                                                    .toString(),
                                                style: AppTextStyles.normal18(
                                                  color: AppColors.green600,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'Có mặt',
                                                style: AppTextStyles.normal14(
                                                  color: AppColors.gray500,
                                                  fontWeight: FontWeight.w400,
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
                                                (newList.isEmpty
                                                        ? listAttendance
                                                        : newList)
                                                    .where((attendance) =>
                                                        attendance.attendance ==
                                                        0)
                                                    .toList()
                                                    .length
                                                    .toString(),
                                                style: AppTextStyles.normal18(
                                                  color: AppColors.red700,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'Vắng',
                                                style: AppTextStyles.normal14(
                                                  color: AppColors.gray500,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: newList.isEmpty
                                    ? listAttendance.length
                                    : newList.length,
                                itemBuilder: (context, index) {
                                  final item = newList.isEmpty
                                      ? listAttendance[index]
                                      : newList[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (newList.isEmpty) {
                                            if (listAttendance[index]
                                                    .attendance ==
                                                1) {
                                              listAttendance[index].attendance =
                                                  0;
                                              listAttendance[index]
                                                  .leaveApplication = 0;
                                            } else {
                                              listAttendance[index].attendance =
                                                  1;
                                            }
                                          } else {
                                            if (newList[index].attendance ==
                                                1) {
                                              newList[index].attendance = 0;
                                              newList[index].leaveApplication =
                                                  0;
                                            } else {
                                              newList[index].attendance = 1;
                                            }
                                          }

                                          checkAttendance(
                                              newAttendance: newList.length == 0
                                                  ? listAttendance
                                                  : newList);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        detailTeacher.info
                                                            .urlImage.mobile),
                                                  ),
                                                  shape: BoxShape.circle,
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                    color: AppColors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.pupilName,
                                                    style:
                                                        AppTextStyles.normal14(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .brand600),
                                                  ),
                                                  Text(
                                                    item.pupliId.toString(),
                                                    style:
                                                        AppTextStyles.normal12(
                                                            color: AppColors
                                                                .secondary),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              if (item.leaveApplication == 1 &&
                                                  item.attendance == 0)
                                                Text(
                                                  'Có phép',
                                                  style: AppTextStyles.normal12(
                                                      color:
                                                          AppColors.orange400),
                                                ),
                                              if (item.attendance == 1)
                                                Assets.icons.checkDone.svg(),
                                              if (item.leaveApplication == 1 &&
                                                  item.attendance == 0)
                                                Assets.icons.absent.svg(),
                                              if (item.attendance == 0 &&
                                                  item.leaveApplication == 0)
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color: AppColors.red),
                                                  child: Assets.icons.x.svg(
                                                      color: AppColors.white),
                                                ),
                                              if (item.attendance == null)
                                                Assets.icons.checkBox.svg()
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (newList.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final List<Map<String, dynamic>>
                                          listEdit = [];
                                      for (var index in newList) {
                                        if (index.attendance != null) {
                                          listEdit.add(
                                            {
                                              "schedule_id": index.scheduleId,
                                              "bus_attendance_id": index.id,
                                              "pupil_id": index.pupliId,
                                              "attendance": index.attendance
                                            },
                                          );
                                        }
                                      }
                                      context.read<BusBloc>().add(
                                            PostEditAttendance(
                                              listEdit: listEdit,
                                              scheduleIdl: widget
                                                      .busScheduleTeacher?.id ??
                                                  0,
                                              type: 'check_out',
                                            ),
                                          );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(6),
                                      backgroundColor: AppColors.red900,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Assets.icons.editProfile.svg(
                                            width: 24,
                                            height: 24,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white, BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Hoàn tất điểm danh',
                                            style: AppTextStyles.semiBold14(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
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
            );
          }),
        ));
  }
}
