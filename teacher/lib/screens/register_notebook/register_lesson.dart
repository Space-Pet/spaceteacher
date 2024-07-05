import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/components/dialog/show_dialog.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/screate_register_book.dart';

class RegisterItem extends StatelessWidget {
  const RegisterItem({
    super.key,
    required this.lesson,
    required this.noBoder,
    required this.onBack,
  });

  final List<LessonDataItem> lesson;
  final bool noBoder;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterNotebookBloc, RegisterNotebookState>(
        builder: (context, state) {
      final classCn = state.classCn;
      final classType = state.classSelect;
      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: lesson.length,
          itemBuilder: (context, index) {
            final item = lesson[index];
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                border: Border(
                  bottom: noBoder
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.gray300),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tiết ${item.tietNum}',
                          style: AppTextStyles.normal14(
                            color: AppColors.black24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            if (item.lessonNote != null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ShowDialog(
                                      title: 'Nhận xét',
                                      textConten: item.lessonNote ?? '',
                                      child: const CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Color(0xFFECFDF3),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Color(0xFFD1FADF),
                                          child: Icon(
                                            Icons.done,
                                            color: AppColors.green600,
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              mainNavKey.currentContext?.push(
                                CreateRegisterBookScreen(
                                  onBack: onBack,
                                  lessonDataItem: item,
                                ),
                              );
                            }
                          },
                          child: classType == 1
                              ? item.lessonNote == null
                                  ? const SizedBox()
                                  : Row(
                                      children: [
                                        Assets.icons.registerDocument.svg(),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Đã phê sổ',
                                          style: AppTextStyles.normal14(
                                              color: AppColors.black24),
                                        ),
                                      ],
                                    )
                              : Row(
                                  children: [
                                    if (item.lessonNote == null)
                                      Assets.icons.registerTeacher.svg()
                                    else
                                      Assets.icons.registerDocument.svg(),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.lessonNote == null
                                          ? 'Phê sổ'
                                          : 'Đã phê sổ',
                                      style: AppTextStyles.normal14(
                                          color: AppColors.black24),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 4,
                            decoration: BoxDecoration(
                                color: AppColors.brand600,
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    maxLines: 2,
                                    classType != 1
                                        ? 'Lớp ${item.className}'
                                        : item.subjectName,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.green600),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (classType == 1 &&
                                    (item.lessonName == null ||
                                        (item.lessonName ?? '').isEmpty))
                                  const SizedBox()
                                else
                                  Text(
                                    classType == 1
                                        ? item.lessonName ?? ''
                                        : item.subjectName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.normal14(
                                        color: AppColors.gray61),
                                  ),
                                const SizedBox(height: 4),
                                if (classType == 1)
                                  Text(
                                    'GV: ${item.teacherName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.normal12(
                                        color: AppColors.gray61),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}
