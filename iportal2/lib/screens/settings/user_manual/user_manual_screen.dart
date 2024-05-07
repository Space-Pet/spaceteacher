import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:core/resources/resources.dart';
import 'package:iportal2/screens/settings/user_manual/model.dart';

class UserManualScreen extends StatefulWidget {
  const UserManualScreen({super.key});

  @override
  State<UserManualScreen> createState() => _UserManualScreenState();
}

class _UserManualScreenState extends State<UserManualScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        children: [
          ScreenAppBar(
            title: 'Hướng dẫn sử dụng',
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
                itemCount: userManual.length,
                itemBuilder: (context, index) {
                  final item = userManual[index];
                  return Column(
                    children: [
                      GFAccordion(
                        expandedTitleBackgroundColor: Colors.white,
                        titlePadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.zero,
                        titleChild: Text(
                          '${item.id} ${item.title}',
                          style: AppTextStyles.normal16(
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray700,
                          ),
                        ),
                        contentChild: Column(
                            children: item.content.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 8, right: 8),
                                  child: CircleAvatar(
                                    radius: 3,
                                    backgroundColor: AppColors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(e.content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5),
                                )
                              ],
                            ),
                          );
                        }).toList()),
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
