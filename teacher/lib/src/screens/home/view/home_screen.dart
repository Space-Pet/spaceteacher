import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/components/back_ground_container.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';

import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/resources.dart';
import 'package:teacher/src/screens/home/bloc/home_bloc.dart';

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

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.user,
  });

  final UserInfo user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 36, 8, 28),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.whiteBackground,
            radius: 21,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.transparent,
              child: Image.network("${user.schoolLogo}"),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.name}",
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${user.className}",
                style: const TextStyle(color: AppColors.white, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: AppColors.whiteOpacity.withOpacity(0.3),
            radius: 20,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              child: Assets.images.noti.image(),
            ),
          ),
        ],
      ),
    );
  }
}

class CenterPositioned extends StatelessWidget {
  const CenterPositioned({
    super.key,
    required this.child,
    required this.top,
  });

  final double top;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: top.v,
      child: child,
    );
  }
}
