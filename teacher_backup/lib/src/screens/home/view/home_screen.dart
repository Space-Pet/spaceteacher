import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/components/center_positioned.dart';

import 'package:teacher/repository/user_repository/user_repositories.dart';

import 'package:teacher/src/screens/home/bloc/home_bloc.dart';
import 'package:teacher/src/screens/home/widgets/home_app_bar.dart';

import 'package:teacher/src/screens/home/widgets/images_library.dart';
import 'package:teacher/src/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';
import 'package:teacher/src/screens/home/widgets/noti_slider.dart';
import 'package:teacher/src/screens/home/widgets/pin_features/pin_features_view.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc(userRepository: Injection.get<UserRepository>());

  @override
  void initState() {
    bloc.add(const HomeInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          final user = state.userInfo;
          final isKinderGarten = state.userInfo.isKinderGarten();

          return Scaffold(
            backgroundColor: AppColors.black,
            body: Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                BackGroundContainer(
                  child: Container(),
                ),
                HomeAppBar(user: user),

                CenterPositioned(
                  top: isKinderGarten ? 330 : 310,
                  child: const NotiSlider(),
                ),

                // Menu
                CenterPositioned(
                  top: isKinderGarten ? 500 : 468,
                  child: PinFeatures(
                    userInfo: user,
                    isKinderGarten: isKinderGarten,
                  ),
                ),
                // Widget can be expanded and overlapped
                CenterPositioned(
                  top: isKinderGarten ? 100 : 88,
                  child: isKinderGarten
                      ? const ImagesLibrary()
                      : const InstructionNotebook(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
