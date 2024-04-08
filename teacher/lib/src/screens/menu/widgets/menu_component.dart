import 'package:flutter/material.dart';
import 'package:teacher/model/dish_menu_model.dart';
import 'package:teacher/model/menu.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/menu/detail_menu_screen.dart';
import 'package:teacher/src/utils/extension_context.dart';

class MenuComponent extends StatelessWidget {
  const MenuComponent({
    super.key,
    required this.menu,
    required this.color,
    required this.image,
  });
  final Menu menu;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    menu.item?.decscription ?? "",
                    style: AppTextStyles.normal14(
                        fontWeight: FontWeight.w600, color: AppColors.brand600),
                  ),
                  IconButton(
                      onPressed: () {
                        context.push(
                          DetailMenuScreen.routeName,
                          arguments: {"item": menu},
                        );
                      },
                      icon: const Icon(Icons.keyboard_arrow_right))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: menu.item?.dish?.length ?? 1,
                          itemBuilder: (BuildContext context, int index) {
                            final item =
                                menu.item?.dish?[index] ?? const Dish();
                            return Row(
                              children: [
                                const Icon(
                                  Icons.done,
                                  color: AppColors.green,
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    item.dish ?? "",
                                    style: AppTextStyles.normal12(
                                        fontWeight: FontWeight.w400,
                                        height: 0.12),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(flex: 1, child: Image.asset(image))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
