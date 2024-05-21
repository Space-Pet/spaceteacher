// ignore_for_file: use_build_context_synchronously

import 'package:core/core.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:teacher/resources/assets.gen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileBottomSheet extends StatefulWidget {
  final VoidCallback? onIndexChanged;

  const ProfileBottomSheet({Key? key, this.onIndexChanged}) : super(key: key);

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  late List<bool> isSelected;
  final int childCount = 4;

  @override
  void initState() {
    super.initState();
    loadSavedSelections();
  }

  void loadSavedSelections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSelected = List.generate(
        childCount,
        (index) => prefs.getBool('selection_$index') ?? false,
      );
    });
  }

  Future<void> saveSelection(int index, bool selected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('selection_$index', selected);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final isLastIndex = index == childCount - 1;
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                        await saveSelection(index, isSelected[index]);

                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: isSelected[index]
                                      ? AppColors.green
                                      : AppColors.gray400,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        'assets/images/avatar.png',
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nguyễn Ngọc Tuyết Lan',
                                          style: AppTextStyles.semiBold12(
                                            color: AppColors.black,
                                            height: 18 / 12,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Assets.icons.academic.svg(
                                              color: AppColors.black,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                'UKA Vũng Tàu',
                                                style: AppTextStyles.normal12(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Container(
                                                width: 5,
                                                height: 5,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                '6.1',
                                                style: AppTextStyles.normal12(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (!isLastIndex)
                            const SizedBox(
                              width: double.infinity,
                              child: DottedLine(
                                dashLength: 2,
                                dashColor: AppColors.gray700,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  childCount: childCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
