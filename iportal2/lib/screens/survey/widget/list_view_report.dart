import 'package:core/data/models/report_student.dart';
import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';


class ListViewReport extends StatefulWidget {
  const ListViewReport({super.key, this.reportStudent});
  final ReportStudent? reportStudent;
  @override
  State<ListViewReport> createState() => _ListViewReportState();
}

class _ListViewReportState extends State<ListViewReport> {
  List<bool> isAccordionExpanded = [];
  @override
  void initState() {
    super.initState();
    // Khởi tạo trạng thái mở hoặc đóng của từng GFAccordion
    isAccordionExpanded = List.generate(
      widget.reportStudent?.dataItems.length ?? 0,
      (index) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.reportStudent?.dataItems.length ?? 0,
        itemBuilder: (context, index) {
          final item = widget.reportStudent?.dataItems[index];

          return Padding(
            padding: EdgeInsets.zero,
            child: GFAccordion(
                onToggleCollapsed: (value) {
                  setState(() {
                    isAccordionExpanded[index] = !isAccordionExpanded[index];
                  });
                  print('bool: ${isAccordionExpanded}');
                },
                titleBorderRadius: isAccordionExpanded[index]
                    ? BorderRadius.circular(10)
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                expandedTitleBackgroundColor: AppColors.purple300,
                collapsedTitleBackgroundColor: AppColors.purple300,
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                titleChild: Container(
                    padding:
                        const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item?.title ?? '',
                      style: AppTextStyles.normal14(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    )),
                contentChild: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.purple300,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: item?.childrenItems.map((childrenItem) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8),
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                  color: AppColors.purple50,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      childrenItem.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.brand600),
                                    ),
                                  ),
                                  ...childrenItem.dataChildrenItems
                                      .map((dataChildrenItem) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dataChildrenItem.title,
                                              style: AppTextStyles.normal14(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.gray800),
                                            ),
                                            ...dataChildrenItem.listCriterial
                                                .map((e) {
                                              final marks = widget
                                                  .reportStudent?.listMarks
                                                  .where((element) =>
                                                      element.id ==
                                                      e.result.first.markId);
                                              final markValues = marks
                                                      ?.map(
                                                          (mark) => mark.value)
                                                      .toList() ??
                                                  [];
                                              final textToShow =
                                                  markValues.join(', ');
                                              Color textColor;
                                              if (textToShow == '1') {
                                                textColor = Colors.red;
                                              } else if (textToShow == '2') {
                                                textColor = AppColors.brand600;
                                              } else if (textToShow == '3') {
                                                textColor = AppColors.green700;
                                              } else {
                                                textColor = Colors.black;
                                              }
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 6),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .brand600,
                                                            radius: 3,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8,
                                                                    right: 6),
                                                            child: Text(
                                                                e
                                                                    .criterialTitle,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    textToShow,
                                                    style:
                                                        AppTextStyles.normal18(
                                                            color: textColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  )
                                                ],
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          );
                        }).toList() ??
                        [],
                  ),
                )),
          );
        });
  }
}
