import 'package:core/core.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher/app_config/router_configuration.dart';

class DialogConfirm extends StatelessWidget {
  const DialogConfirm({
    super.key,
    required this.title,
    required this.content,
    this.yesText,
    this.noText,
    this.onYes,
    this.onNo,
    required this.lesson,
  });

  final String title;
  final String content;
  final String? yesText;
  final String? noText;
  final Function? onYes;
  final Function? onNo;
  final RegisteredLesson lesson;

  @override
  Widget build(BuildContext context) {
    // format lesson.lessonRegisterDate type String to dd/MM/yyyy
    final dateFomat = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(lesson.lessonRegisterDate));

    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTextStyles.semiBold18(
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold14(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                TextDotLineDialog(
                  title: 'Thời gian dự giờ',
                  value: dateFomat,
                ),
                TextDotLineDialog(
                    title: 'Giáo viên',
                    value: lesson.lessonRegisterTeacherName),
                TextDotLineDialog(
                  title: 'Lớp',
                  value: lesson.lessonRegisterClassName,
                ),
                TextDotLineDialog(
                  title: 'Tiết',
                  value: lesson.lessonRegisterTietNum,
                  isLastLine: true,
                ),
                TextDotLineDialog(
                  title: 'Môn',
                  value: lesson.lessonRegisterSubjectName,
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (onYes != null) {
                    onYes!();
                  }
                  // context.pop();
                },
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  elevation: 0,
                  backgroundColor: AppColors.brand500,
                  side: const BorderSide(color: AppColors.gray400),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  yesText ?? 'Xác nhận',
                  style: AppTextStyles.semiBold16(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (onNo != null) {
                    onNo!();
                  }
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    alignment: Alignment.center,
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.gray400),
                    padding: const EdgeInsets.symmetric(vertical: 12)),
                child: Text(
                  noText ?? 'No',
                  style: AppTextStyles.semiBold16(color: AppColors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextDotLineDialog extends StatelessWidget {
  const TextDotLineDialog({
    required this.title,
    required this.value,
    this.isFirstLine = false,
    this.isLastLine = false,
    super.key,
  });
  final String title;
  final String value;
  final bool isFirstLine;
  final bool isLastLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.semiBold14(color: AppColors.gray500),
              ),
              Text(
                value,
                style: AppTextStyles.semiBold14(
                    color: isFirstLine
                        ? AppColors.blueForgorPassword
                        : AppColors.gray700),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (!isLastLine)
            const DottedLine(
              dashLength: 1,
              dashColor: AppColors.gray500,
            ),
        ],
      ),
    );
  }
}
