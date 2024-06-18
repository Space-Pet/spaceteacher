import 'package:core/core.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repository/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class CardBusItem extends StatelessWidget {
  const CardBusItem({
    super.key,
    required this.busSchedule,
  });
  final BusSchedule busSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              if (busSchedule.checkInTime().isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  decoration: BoxDecoration(
                    color: AppColors.green100,
                    borderRadius: AppRadius.rounded4,
                  ),
                  child: Text(
                    busSchedule.checkInTime(),
                    style: AppTextStyles.semiBold14(
                      color: AppColors.black24,
                    ),
                  ),
                ),
              if (busSchedule.checkOutTime().isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(left: 6),
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  decoration: BoxDecoration(
                    color: AppColors.green400,
                    borderRadius: AppRadius.rounded4,
                  ),
                  child: Text(
                    busSchedule.checkOutTime(),
                    style: AppTextStyles.semiBold14(
                      color: AppColors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
        collapsed: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          child: Column(
            children: [
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
                  label: 'Biển số xe',
                  value: busSchedule.driverInfo.numberPlate,
                ),
              ),
              const _Divider(),
              const SizedBox(height: 6),
              TeacherInfo(busSchedule: busSchedule),
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
                  TeacherInfo(busSchedule: busSchedule),
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

class TeacherInfo extends StatelessWidget {
  const TeacherInfo({
    super.key,
    required this.busSchedule,
  });

  final BusSchedule busSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Bảo mẫu',
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
                maxRadius: 18,
                backgroundColor: AppColors.brand600,
                child: SvgPicture.asset(
                    width: 20, height: 20, 'assets/icons/send-message-bus.svg'),
              ),
              if (busSchedule.teacher.mobilePhone.isNotEmpty)
                InkWell(
                  onTap: () {
                    launchUrl(
                        Uri.parse("tel:${busSchedule.teacher.mobilePhone}"));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      maxRadius: 18,
                      backgroundColor: AppColors.red900,
                      child: SvgPicture.asset(
                          width: 22,
                          height: 22,
                          'assets/icons/phone-call-bus.svg'),
                    ),
                  ),
                )
            ],
          ),
        ],
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
