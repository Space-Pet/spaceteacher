import 'package:core/common/utils/snackbar.dart';
import 'package:core/data/models/leaves_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/resources/resources.dart';
import 'package:intl/intl.dart';
import 'package:teacher/screens/leave/bloc/leave_bloc.dart';

class LeaveInfoDialog extends StatelessWidget {
  const LeaveInfoDialog({
    super.key,
    required this.bloc,
    required this.leaveInfo,
    this.hasApproved = false,
  });

  final LeaveBloc bloc;
  final LeaveTeacher leaveInfo;
  final bool hasApproved;

  @override
  Widget build(BuildContext context) {
    final listInfoW = List.generate(ListInfoKey.values.length, (index) {
      final keyInfo = ListInfoKey.values[index];
      DateFormat formatDate = DateFormat('EEEE, dd/MM/yyyy HH:mm', 'vi_VN');

      final leaveInfoData = {
        'pupilName': leaveInfo.pupilName,
        'pupilId': leaveInfo.pupilId.toString(),
        'status': leaveInfo.status.value.text,
        'startDate': formatDate.format(leaveInfo.startDate),
        'endDate': formatDate.format(leaveInfo.endDate),
      };

      return LeaveInfoItem(
        title: keyInfo.value,
        content: leaveInfoData[keyInfo.name] ?? '',
      );
    });

    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<LeaveBloc, LeaveState>(
        listener: (context, state) {
          final status = state.leaveStatus;
          if (status == LeaveTeacherStatus.approveSuccess) {
            Navigator.pop(context);
            SnackBarUtils.showFloatingSnackBar(context, 'Duyệt thành công!');
          }
        },
        builder: (context, state) {
          final errMsg = state.message;

          return Container(
            decoration: const BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  leaveInfo.title,
                  style: AppTextStyles.semiBold20(color: AppColors.gray900),
                ),
                const SizedBox(height: 8),
                Text(
                  'Lý do: ${leaveInfo.content}',
                  style: AppTextStyles.semiBold16(color: AppColors.gray800),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: listInfoW,
                  ),
                ),
                if ((errMsg ?? '').isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      errMsg ?? '',
                      style: AppTextStyles.normal14(color: AppColors.redMenu),
                    ),
                  ),
                if (!hasApproved)
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 6),
                    child: ElevatedButton(
                      onPressed: () {
                        // bloc.add(ApproveLeave(leaveInfo.id));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redMenu,
                      ),
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          child: Text(
                            'Duyệt đơn',
                            style: AppTextStyles.semiBold16(
                                color: AppColors.white),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                const SizedBox(height: 4),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color?>(AppColors.white),
                    side: WidgetStateProperty.all<BorderSide>(
                      const BorderSide(color: AppColors.gray300),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        style:
                            AppTextStyles.semiBold16(color: AppColors.gray900),
                        'Đóng',
                        textAlign: TextAlign.center,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum ListInfoKey {
  pupilName,
  pupilId,
  status,
  startDate,
  endDate,
}

extension ListInfoKeyExtension on ListInfoKey {
  String get value {
    switch (this) {
      case ListInfoKey.pupilName:
        return 'Họ và tên';
      case ListInfoKey.pupilId:
        return 'Mã học sinh';
      case ListInfoKey.status:
        return 'Lớp';
      case ListInfoKey.startDate:
        return 'Nghỉ từ ngày';
      case ListInfoKey.endDate:
        return 'Đến ngày';
    }
  }
}

class LeaveInfoItem extends StatelessWidget {
  const LeaveInfoItem({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.normal14(
              color: AppColors.gray600,
            ),
          ),
          Text(
            content,
            style: AppTextStyles.normal14(
              color: title == ListInfoKey.pupilName.value
                  ? AppColors.blue600
                  : AppColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}
