import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teacher/model/bus_model.dart';
import 'package:teacher/resources/resources.dart';

class CardBusItem extends StatelessWidget {
  const CardBusItem({
    super.key,
    required this.busSchedule,
  });
  final BusModel busSchedule;

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
                decoration: const BoxDecoration(
                    color: AppColors.green100,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  busSchedule.busId.toString(),
                  style: AppTextStyles.semiBold12(color: AppColors.black24),
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
                  value: '${busSchedule.routeId}',
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
                  value: busSchedule.numberPlate ?? "",
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
                      value: '${busSchedule.routeId}',
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
                      value: busSchedule.numberPlate ?? "",
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
                      value: busSchedule.departureTime ?? "",
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
                      value: busSchedule.scheduleType.toString(),
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
                      value: "${busSchedule.routeId} ${busSchedule.routeName}",
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
                      value: busSchedule.departureTime ?? "",
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
                              '${busSchedule.teacherId}',
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
                        Text(busSchedule.subDriver ?? "",
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
