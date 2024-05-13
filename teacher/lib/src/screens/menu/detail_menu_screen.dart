import 'package:flutter/material.dart';

import 'package:teacher/components/app_bar/app_bar.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/dish_menu_model.dart';
import 'package:teacher/model/menu.dart';
import 'package:core/resources/resources.dart';
import 'package:teacher/src/utils/extension_context.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key, required this.item});
  final Menu item;
  static const routeName = '/detailMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackGroundContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenAppBar(
              canGoback: true,
              title: item.item?.decscription ?? "",
              onBack: () {
                context.pop();
              },
            ),
            Flexible(
                child: Container(
              padding: const EdgeInsets.only(left: 24, top: 24, right: 12),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount: item.item?.dish?.length ?? 1,
                        itemBuilder: (context, index) {
                          final Dish value =
                              item.item?.dish?[index] ?? const Dish();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                value.image ?? "",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(value.dish ?? ""),
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
