import 'package:flutter/material.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/components/app_bar/app_bar.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/components/select_child.dart';
import 'package:iportal2/screens/phone_book/widget/tab_bar_phone_book.dart';

import '../../resources/app_colors.dart';

class PhoneBookScreen extends StatelessWidget {
  const PhoneBookScreen({super.key});

  static const routeName = '/phone_book';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BackGroundContainer(
        child: Column(
          children: [
            ScreenAppBar(
              title: 'Danh bạ',
              canGoback: true,
              onBack: () {
                context.pop();
              },
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: SelectChild(),
                    ),
                    const SizedBox(height: 8),
                    TabBarPhoneBook(),
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
