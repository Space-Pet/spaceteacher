import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/app_config/router_configuration.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/resources.dart';
import 'package:iportal2/screens/profile/widget/profile_app_bar.dart';
import 'package:iportal2/screens/profile/widget/tab_bar_parent.dart';

import 'widget/tab_bar_student.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';

  final int role = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        return BackGroundContainer(
          child: Column(
            children: [
              ProfileAppBar(
                onBack: () {
                  context.pop();
                },
                role: role,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Image(
                          image: state.user.brandLogo(),
                          height: 100,
                        ),
                      ),
                      if (role == 0) const TabBarStudent(),
                      if (role == 1) const TabBarParent()
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

