import 'package:core/resources/assets.gen.dart';
import 'package:core/resources/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:teacher/components/tab/tab_content.dart';
import 'package:teacher/model/leave_model.dart';
import 'package:teacher/src/screens/leave/widget/info_popup.dart';

class ApplicationItem extends StatelessWidget {
  const ApplicationItem({
    super.key,
    this.application,
  });

  final LeaveModel? application;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Đơn xin nghỉ phép",
                textAlign: TextAlign.center,
              ),
              content: IntrinsicHeight(
                child: Column(
                  children: [
                    InfoPopup(
                      title: 'Họ và tên',
                      content: application?.pupilName ?? '',
                      color: AppColors.blue600,
                    ),
                    InfoPopup(
                      title: 'Mã học sinh',
                      content: application?.pupilId.toString() ?? '',
                    ),
                    InfoPopup(
                      title: 'Lớp',
                      content: application?.pupilName ?? '',
                    ),
                    InfoPopup(
                      title: 'Nghỉ từ ngày',
                      content: application?.pupilName ?? '',
                    ),
                    InfoPopup(
                      title: 'Đến ngày',
                      content: application?.pupilName ?? '',
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Đóng"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.gray100),
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.blueGray100,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SvgPicture.asset(
                  Assets.icons.calendarLeave,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ApplicationHeader(
                    title: application?.title ?? '',
                    status: application,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppColors.gray400,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            DateFormat('dd/MM/yyyy')
                                .format(
                                    application?.startDate ?? DateTime.now())
                                .toString(),
                            style: AppTextStyles.normal12(
                                color: AppColors.gray400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    application?.content ?? '',
                    style: AppTextStyles.normal14(color: AppColors.gray600),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicationHeader extends StatelessWidget {
  const ApplicationHeader({super.key, required this.title, this.status});

  final LeaveModel? status;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold14(color: AppColors.gray800),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: status?.status.text == 'Đã duyệt'
                ? AppColors.green100
                : AppColors.warning100,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            child: Text(
              status?.status.text ?? '',
              style: AppTextStyles.normal12(
                color: status?.status.text == 'Đã duyệt'
                    ? AppColors.green700
                    : AppColors.warning500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
