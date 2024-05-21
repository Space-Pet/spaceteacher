import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repository/repository.dart';

class CardBusItem extends StatelessWidget {
  const CardBusItem({
    super.key,
    required this.busSchedule,
  });
  final BusSchedule busSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.blueGray100),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: AppColors.gray9000c,
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          iconPadding: EdgeInsets.fromLTRB(12, 12, 12, 8),
          alignment: Alignment.topCenter,
        ),
        header: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                decoration: BoxDecoration(
                    color: busSchedule.isCompleted
                        ? AppColors.green400
                        : AppColors.green100,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Text(
                  busSchedule.title(),
                  style: AppTextStyles.semiBold12(
                    color: busSchedule.isCompleted
                        ? AppColors.white
                        : AppColors.black24,
                  ),
                ),
              ),
            ],
          ),
        ),
        collapsed: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _Item(
                  label: 'Tuyến',
                  value: '${busSchedule.route.routeId}',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: _Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: _Item(
                  label: 'Biển số xe',
                  value: busSchedule.driverInfo.numberPlate,
                ),
              ),
              const _Divider(),
            ],
          ),
        ),
        expanded: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Item(
                      label: 'Tuyến',
                      value: '${busSchedule.route.routeId}',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Item(
                      label: 'Biển số xe',
                      value: busSchedule.driverInfo.numberPlate,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Item(
                      label: 'Ngày',
                      value: busSchedule.attendanceDateString(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Item(
                      label: 'Loại tuyến',
                      value: busSchedule.scheduleType.text,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Item(
                      label: 'Điểm đón',
                      value: busSchedule.pickupLocation(),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: _Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Item(
                      label: 'Thời gian dự kiến đón',
                      value: busSchedule.estimatedTime(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.gray300,
              ))),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: AppColors.blueGray50,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giáo viên',
                              softWrap: true,
                              style: AppTextStyles.semiBold14(
                                color: AppColors.gray600,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              busSchedule.teacher.teacherName,
                              softWrap: true,
                              style: AppTextStyles.normal14(
                                color: AppColors.gray600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 16,
                              backgroundColor: AppColors.brand600,
                              child: SvgPicture.asset(
                                  width: 17,
                                  height: 17,
                                  'assets/icons/send-message-bus.svg'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              maxRadius: 16,
                              backgroundColor: AppColors.red900,
                              child: SvgPicture.asset(
                                  width: 17,
                                  height: 17,
                                  'assets/icons/phone-call-bus.svg'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: AppColors.blueGray50,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lái xe',
                            softWrap: true,
                            style: AppTextStyles.semiBold14(
                              color: AppColors.gray600,
                            )),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(busSchedule.driverInfo.driverName,
                            softWrap: true,
                            style: AppTextStyles.normal14(
                              color: AppColors.gray600,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: DottedLine(
        dashLength: 2,
        dashColor: AppColors.gray300,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    // ignore: unused_element
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          softWrap: true,
          style: AppTextStyles.normal14(
            color: AppColors.gray600,
          ),
        ),
        Text(
          value,
          softWrap: true,
          style: AppTextStyles.semiBold14(
            color: AppColors.gray600,
          ),
        ),
      ],
    );
  }
}
