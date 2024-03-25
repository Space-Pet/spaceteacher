import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:iportal2/screens/menu/models/menu.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({required this.item});
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
              title: item.item.decscription,
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
                        itemCount: item.item.dish.length,
                        itemBuilder: (context, index) {
                          final value = item.item.dish[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(value.image),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(value.dish),
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
