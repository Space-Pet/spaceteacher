import 'package:core/core.dart';
import 'package:core/data/models/weeky_lesson.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:teacher/app_config/router_configuration.dart';
import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/screens/register_notebook/bloc/register_notebook_bloc.dart';
import 'package:teacher/screens/register_notebook/screate_register_book/screate_register_book.dart';

class RegisterItem extends StatelessWidget {
  const RegisterItem({
    super.key,
    required this.lesson,
    required this.noBoder,
  });

  final List<LessonDataItem> lesson;
  final bool noBoder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterNotebookBloc, RegisterNotebookState>(
        builder: (context, state) {
      final classCn = state.classCn;
      return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: lesson.length,
          itemBuilder: (context, index) {
            final item = lesson[index];
            return GestureDetector(
              onTap: () {
                context.push(CreateRegisterBookScreen(
                  lessonDataItem: item,
                ));
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                    Container(
                      padding: const EdgeInsets.only(top: 6),
                      width: 110.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tiết ${item.tietNum}',
                            style: AppTextStyles.normal14(
                                color: AppColors.black24),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              if (item.lessonNote == '')
                                Assets.icons.registerTeacher.svg(),
                              if (item.lessonNote != '')
                                Assets.icons.registerDocument.svg(),
                              const SizedBox(width: 4),
                              Text(
                                item.lessonNote == '' ? 'Phê sổ' : 'Đã phê sổ',
                                style: AppTextStyles.normal14(
                                    color: AppColors.black24),
                              ),
                            ],
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
                                  if (classCn.length != 0)
                                    Expanded(
                                      child: Text(
                                        maxLines: 3,
                                        'Lớp ${classCn.first.className}',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.semiBold14(
                                            color: AppColors.green600),
                                      ),
                                    ),
                                  if (classCn.length == 0)
                                    Expanded(
                                      child: Text(
                                        maxLines: 3,
                                        item.subjectName,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.semiBold14(
                                            color: AppColors.black24),
                                      ),
                                    ),
                                  const SizedBox(height: 4),
                                  if (item.lessonName != 'null')
                                    Text(
                                      item.lessonName ?? 'ss',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.normal12(
                                          color: AppColors.gray61),
                                    ),
                                  const SizedBox(height: 4),
                                  if (classCn.length != 0)
                                    Text(
                                      item.teacherName,
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
              ),
            );
          });
    });
  }
}
