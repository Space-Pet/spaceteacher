import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/select_child.dart';
import 'package:iportal2/components/select_date.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/screens/menu/models/menu.dart';
import 'package:iportal2/screens/menu/widgets/menu_component.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  static const routeName = '/menu';
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenAppBar(
            title: 'Thực đơn',
            canGoback: true,
            onBack: () {
              context.pop();
            },
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
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
                  const SelectChild(),
                  const SizedBox(height: 12),
                  SelectDate(
                    onDatePicked: (date) {
                      print("Selected date in parent: $date");
                    },
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: ListView.builder(
                        itemCount: menu.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          final item = menu[index];
                          String image = '';
                          Color color = AppColors.lightSkyBlue;
                          double padding = 0;
                          switch (index) {
                            case 0:
                              image = 'assets/images/breakfast.png';
                              color = AppColors.lightSkyBlue;
                              padding = 10;
                            case 1:
                              image = 'assets/images/lunch.png';
                              color = AppColors.lightPink;
                              padding = 0;
                            case 2:
                              image = 'assets/images/brunch.png';
                              color = AppColors.lightSkyBlue;
                              padding = 0;
                            case 3:
                              image = 'assets/images/dinner.png';
                              color = AppColors.lightPink;
                              padding = 0;
                            default:
                              image = 'assets/images/breakfast.png';
                              color = AppColors.lightSkyBlue;
                              padding = 0;
                          }
                          return MenuComponent(
                            padding: padding,
                            menu: item,
                            image: image,
                            color: color,
                          );
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
