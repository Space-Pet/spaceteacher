import 'package:core/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/resources/resources.dart';

class ApplicationItem extends StatelessWidget {
  const ApplicationItem({
    super.key,
    required this.application,
  });

  final LeaveData application;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  title: application.title,
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
                              .format(application.startDate)
                              .toString(),
                          style:
                              AppTextStyles.normal12(color: AppColors.gray400),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  application.content,
                  style: AppTextStyles.normal14(color: AppColors.gray600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationHeader extends StatelessWidget {
  const ApplicationHeader(
      {super.key, required this.title, required this.status});

  final LeaveData status;
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
            color: status.text == 'Đã duyệt'
                ? AppColors.green100
                : AppColors.warning100,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            child: Text(
              status.text,
              style: AppTextStyles.normal12(
                color: status.text == 'Đã duyệt'
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
