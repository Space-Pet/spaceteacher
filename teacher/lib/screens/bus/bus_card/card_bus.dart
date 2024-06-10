import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/bus/bus_card/choose_attendance_bus_screen.dart';
import 'package:teacher/screens/bus/detail_bus_schedule_screen.dart';

class CardBus extends StatelessWidget {
  const CardBus({
    super.key,
    required this.busScheduleTeacher,
  });
  final BusScheduleTeacher busScheduleTeacher;

  @override
  Widget build(BuildContext context) {
    String formatTime(String dateTime) {
      DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('HH:mm').format(parsedDate);
    }

    return GestureDetector(
      onTap: () {
        context.push(DetailBusScheduleScreen(
          busScheduleTeacher: busScheduleTeacher,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: busScheduleTeacher.isCompleted == true
                        ? AppColors.gray200
                        : AppColors.brand600,
                    // color: AppColors.brand600,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      busScheduleTeacher.routeName ?? '',
                      style: AppTextStyles.normal14(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (busScheduleTeacher.isCompleted == true)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.observationStatusSuccessdBg,
                    ),
                    child: Row(
                      children: [
                        Assets.icons.checkCircleGreen.svg(),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text('Đã điểm danh',
                              style: AppTextStyles.normal12(
                                  color: AppColors.greenSwitch)),
                        )
                      ],
                    ),
                  ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: AppColors.brand600,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: busScheduleTeacher.isCompleted == true
                              ? AppColors.gray200
                              : AppColors.observationStatusSuccessText,
                        ),
                        child: Text(
                          '${formatTime(busScheduleTeacher.departureTime ?? '')} - ${formatTime(busScheduleTeacher.endTime ?? '')}',
                          style: AppTextStyles.normal12(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        'Tổng sô học sinh cần đón (${busScheduleTeacher.totalPupil})',
                        style: AppTextStyles.normal14(
                          color: AppColors.blue600,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vắng',
                          style: AppTextStyles.normal16(
                            color: AppColors.gray600,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          busScheduleTeacher.absence?.count.toString() ?? '',
                          style: AppTextStyles.normal16(
                            color: AppColors.primaryRedColor,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: busScheduleTeacher.absence?.pupils?.map((items) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.observationStatusPendingBg,
                                border: Border.all(
                                  color: AppColors.lightRed,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              items.avatar?.mobile ?? '',
                                            ),
                                          ),
                                          shape: BoxShape.circle,
                                          color: AppColors.white,
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              items.fullName ?? '',
                                              style: AppTextStyles.normal16(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  items.id.toString(),
                                                  style: AppTextStyles.normal16(
                                                    color: AppColors.gray500,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                // Container(
                                                //   height: 5,
                                                //   width: 5,
                                                //   decoration: BoxDecoration(
                                                //       color: AppColors.gray500,
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               20)),
                                                // ),
                                                // const SizedBox(
                                                //   width: 8,
                                                // ),
                                                // Text(
                                                //   '6.1',
                                                //   style: AppTextStyles.normal16(
                                                //     color: AppColors.gray500,
                                                //     fontWeight: FontWeight.w400,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Vắng',
                                    style: AppTextStyles.normal14(
                                        color: AppColors.red),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList() ??
                        [],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
