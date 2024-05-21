import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:teacher/src/screens/home/models/lesson_model.dart';

class TabInstruction extends StatelessWidget {
  const TabInstruction({
    super.key,
    this.isTimeTableView = false,
    required this.lessons,
  });

  final List<LessonModel> lessons;
  final bool isTimeTableView;

  @override
  Widget build(BuildContext context) {
    final lessonsWExpanded = List.generate(lessons.length, (index) {
      final lesson = lessons[index];
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: index == lessons.length - 1
              ? AppRadius.roundedBottom12
              : const BorderRadius.all(Radius.zero),
          color: AppColors.gray100,
          border: Border(
            bottom: index == lessons.length - 1
                ? BorderSide.none
                : const BorderSide(color: AppColors.gray300),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 6),
              width: 80,
              child: Text(
                'Tiết ${lesson.number}',
                style: AppTextStyles.normal14(color: AppColors.black24),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: isTimeTableView
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: isTimeTableView ? 51 : 88,
                    decoration: BoxDecoration(
                        color: AppColors.brand600,
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: isTimeTableView
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${lesson.name}',
                                    style: AppTextStyles.semiBold14(
                                        color: AppColors.black24),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'GV: ${lesson.teacherName}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.normal12(
                                        color: AppColors.gray61),
                                  ),
                                ],
                              ),
                              // if (lesson.advice.isNotEmpty)
                              //   GestureDetector(
                              //     onTap: () {
                              //       showDialog(
                              //         context: context,
                              //         builder: (_) => DialogScaleAnimated(
                              //           title: 'Dặn dò',
                              //           content: lesson.advice,
                              //         ),
                              //       );
                              //     },
                              //     child: SvgPicture.asset(
                              //         'assets/icons/advice.svg'),
                              //   ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.name ?? "",
                                style: AppTextStyles.semiBold14(
                                    color: AppColors.black24),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lesson.description ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.normal12(
                                    color: AppColors.gray61),
                              ),
                              const SizedBox(height: 6),
                              if (lesson.fileUrl?.isNotEmpty ?? false)
                                GestureDetector(
                                  onTap: () async {
                                    // try {
                                    //   final theme = Theme.of(context);

                                    //   await launchUrl(
                                    //     Uri.parse(lesson.fileUrl),
                                    //     customTabsOptions: CustomTabsOptions(
                                    //       colorSchemes: CustomTabsColorSchemes.defaults(
                                    //         toolbarColor: theme.colorScheme.surface,
                                    //       ),
                                    //       shareState: CustomTabsShareState.on,
                                    //       urlBarHidingEnabled: true,
                                    //       showTitle: true,
                                    //       closeButton: CustomTabsCloseButton(
                                    //         icon: CustomTabsCloseButtonIcons.back,
                                    //       ),
                                    //     ),
                                    //     safariVCOptions: SafariViewControllerOptions(
                                    //       preferredBarTintColor:
                                    //           theme.colorScheme.surface,
                                    //       preferredControlTintColor:
                                    //           theme.colorScheme.onSurface,
                                    //       barCollapsingEnabled: true,
                                    //       dismissButtonStyle:
                                    //           SafariViewControllerDismissButtonStyle
                                    //               .close,
                                    //     ),
                                    //   );
                                    // } catch (e) {
                                    //   debugPrint(e.toString());
                                    // }
                                    launchUrl(
                                      Uri.parse(lesson.fileUrl ?? ""),
                                      mode: LaunchMode.inAppBrowserView,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/paperclip.svg'),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Baitap.docx',
                                        style: AppTextStyles.normal12(
                                            color: AppColors.brand600),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                labelColor: AppColors.brand600,
                unselectedLabelColor: AppColors.gray500,
                dividerColor: AppColors.gray200,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: AppTextStyles.semiBold14(color: AppColors.brand600),
                unselectedLabelStyle:
                    AppTextStyles.normal14(color: AppColors.gray500),
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  color: AppColors.gray100,
                ),
                tabs: const [
                  Tab(
                    child: Align(
                      child: Text("Buổi sáng"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      child: Text("Buổi chiều"),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                    children: lessonsWExpanded,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: lessonsWExpanded,
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
