import 'package:core/resources/resources.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/screens/settings/faq/model.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
        child: Column(
      children: [
        ScreenAppBar(
          title: 'FAQ',
          canGoback: true,
          onBack: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: faq.length,
                  itemBuilder: (context, index) {
                    final faqs = faq[index];

                    return Column(
                      children: [
                        GFAccordion(
                          expandedTitleBackgroundColor: Colors.white,
                          titlePadding: EdgeInsets.zero,
                          contentPadding: EdgeInsets.zero,
                          titleChild: Text(
                            '${faqs.id} ${faqs.title}',
                            style: AppTextStyles.normal16(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray700,
                            ),
                          ),
                          contentChild: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: ExpansionTileGroup(
                                toggleType: ToggleType.expandOnlyCurrent,
                                children: faqs.question.map((e) {
                                  return ExpansionTileItem(
                                    childrenPadding: EdgeInsets.zero,
                                    tilePadding: EdgeInsets.zero,
                                    title: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.gray100),
                                        child: Text(e.question)),
                                    children: [
                                      Column(
                                          children: e.content.map((content) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, right: 6),
                                              child: CircleAvatar(
                                                radius: 3,
                                                backgroundColor:
                                                    AppColors.black,
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(content.content))
                                          ],
                                        );
                                      }).toList())
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: DottedLine(
                              dashLength: 2,
                              dashColor: AppColors.gray300,
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
        )
      ],
    ));
  }
}
