import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';

class BusScreen extends StatelessWidget {
  const BusScreen({super.key});
  static const routeName = '/bus';
  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenAppBar(
          title: 'Xe đưa đón',
          canGoback: true,
          onBack: () {
            context.pop();
          },
        ),
        const SizedBox(height: 6),
        Flexible(child: Container())
      ],
    ));
  }
}
