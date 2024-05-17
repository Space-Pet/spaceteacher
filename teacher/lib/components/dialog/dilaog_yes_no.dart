import 'package:core/core.dart';
import 'package:core/resources/resources.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:teacher/model/subject_model.dart';

import 'package:teacher/resources/assets.gen.dart';

class DialogYesNo extends StatelessWidget {
  const DialogYesNo(
      {super.key,
      required this.title,
      required this.content,
      required this.typeDialog,
      this.yesText,
      this.noText,
      this.onYes,
      this.onNo,
      this.subjectModel});

  final String title;
  final String content;
  final int typeDialog;
  final String? yesText;
  final String? noText;
  final Function? onYes;
  final Function? onNo;
  final SubjectModel? subjectModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: buildWidgetTypeDialogYesNo(
              typeDialog: typeDialog, context: context)),
    );
  }

  Widget buildWidgetTypeDialogYesNo(
      {required int typeDialog, required BuildContext context}) {
    switch (typeDialog) {
      // Mở lơp dự giờ thành công
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (typeDialog == 1)
              Assets.icons.iconSuccess.svg(
                width: 50,
                height: 50,
              ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.bold16(
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: AppTextStyles.semiBold14(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (onYes != null) {
                      onYes!();
                    }
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    elevation: 0,
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.gray400),
                  ),
                  child: Text(
                    yesText ?? 'Yes',
                    style: AppTextStyles.bold16(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );

      // Xác nhận tham gia dự giờ
      case 2:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.bold16(
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: AppTextStyles.semiBold14(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (onYes != null) {
                      onYes!();
                    }
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    elevation: 0,
                    backgroundColor: AppColors.observationStatusMyObsBG,
                  ),
                  child: Text(
                    yesText ?? 'Yes',
                    style: AppTextStyles.bold16(
                      color: AppColors.white,
                    ),
                  ),
                ),
                ElevatedButton(
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
                  ),
                  child: Text(
                    noText ?? 'No',
                    style: AppTextStyles.bold16(color: AppColors.black),
                  ),
                ),
              ],
            ),
          ],
        );
      case 3:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icons.iconSuccess.svg(
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.bold16(
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: AppTextStyles.semiBold14(
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const TextDotLineDialog(
                    title: 'Thời gian dự giờ',
                    value: '29/02/2024',
                    isFirstLine: true),
                TextDotLineDialog(
                  title: 'Môn',
                  value: '${subjectModel?.subjectName}',
                ),
                TextDotLineDialog(
                    title: 'Giáo viên', value: '${subjectModel?.teacherName}'),
                TextDotLineDialog(
                  title: 'Lớp',
                  value: '${subjectModel?.className}',
                ),
                TextDotLineDialog(
                  title: 'Tiết',
                  value: '${subjectModel?.tietNum}',
                  isLastLine: true,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
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
                ),
                child: Text(
                  noText ?? 'No',
                  style: AppTextStyles.bold16(color: AppColors.black),
                ),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
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
