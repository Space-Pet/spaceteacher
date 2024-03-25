import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/screens/leave/on_leave_screen.dart';
import 'package:iportal2/resources/resources.dart';

class ApplicationItem extends StatelessWidget {
  const ApplicationItem({
    super.key,
    required this.application,
  });

  final LeaveApplicationModel application;

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
            width: 75,
            height: 75,
            child: const Icon(
              Icons.calendar_month,
              size: 40,
              color: Color(0xFF1C274C),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ApplicationHeader(
                  title: application.title,
                  status: application.status,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 12,
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(application.startDate).toString(),
                        style: AppTextStyles.normal12(color: AppColors.gray400),
                      ),
                    ],
                  ),
                ),
                Text(
                  application.reason,
                  style: AppTextStyles.normal14(color: AppColors.gray400),
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
  const ApplicationHeader({super.key, required this.title, required this.status});

  final ApplicationStatus status;
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
            color: status.isApproved ? AppColors.green100 : AppColors.warning100,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            child: Text(
              status.getName(),
              style: AppTextStyles.normal12(
                color: status.isApproved ? AppColors.green700 : AppColors.warning500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
