import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/components/back_ground_container.dart';
import 'package:iportal2/resources/app_size.dart';
import 'package:iportal2/screens/home/bloc/home_bloc.dart';
import 'package:iportal2/screens/home/widgets/home_app_bar.dart';
import 'package:iportal2/screens/home/widgets/images_library.dart';
import 'package:iportal2/screens/home/widgets/instruction_notebook/instruction_notebook_view.dart';
import 'package:iportal2/screens/home/widgets/noti_slider.dart';
import 'package:iportal2/screens/home/widgets/pin_features/pin_features_view.dart';
import 'package:repository/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return BlocProvider(
      create: (context) => HomeBloc(
        context.read<AppFetchApiRepository>(),
        currentUserBloc: context.read<CurrentUserBloc>(),
      ),
      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
          builder: (context, state) {
        final isKinderGarten = state.user.isKinderGarten();

        return BackGroundContainer(
          child: Stack(
            children: [
              const CenterPositioned(
                top: 48,
                child: HomeAppBar(),
              ),
              CenterPositioned(
                top: isKinderGarten ? 346 : 320,
                child: const NotiSlider(),
              ),
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
      }),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
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
