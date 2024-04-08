import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/screens/menu/models/menu.dart';

class DetailMenuScreen extends StatelessWidget {
  const DetailMenuScreen({super.key, required this.item});
  final Menu item;
  static const routeName = '/detailMenu';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemW = (screenWidth - 60) / 3;

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
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 26),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24.0,
                ),
                itemCount: item.item.dish.length,
                itemBuilder: (context, index) {
                  final value = item.item.dish[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: itemW,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(value.image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          textAlign: TextAlign.left,
                          value.dish,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
