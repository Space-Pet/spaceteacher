import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/common_bloc/user_manager/bloc/user_manager_bloc.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';

import 'package:teacher/resources/assets.gen.dart';

class BackGroundContainer extends StatefulWidget {
  const BackGroundContainer({super.key, required this.child});

  final Widget child;

  @override
  State<BackGroundContainer> createState() => _BackGroundContainerState();
}

class _BackGroundContainerState extends State<BackGroundContainer> {
  final bloc = UserManagerBloc(userRepository: Injection.get<UserRepository>());
  @override
  void initState() {
    bloc.add(const UserManagerGetUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagerBloc, UserManagerState>(
      bloc: bloc,
      builder: (context, state) {
        final bgImage = state.userInfo.mainBackGround();
        final size = MediaQuery.of(context).size;
        return Container(
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: bgImage,
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

extension UserBackGround on UserInfo {
  ImageProvider<Object> mainBackGround() {
    if (isKinderGarten()) {
      switch (schoolBrand) {
        case 'uka':
          return Assets.images.mainBackground.ukaPreS.provider();

        case 'ischool':
          return Assets.images.mainBackground.ischoolPreS.provider();

        case 'sga':
          return Assets.images.mainBackground.sgaPreS.provider();

        // case 'sna':
        //   return Assets.images.mainBackground.snaPreS.provider();

        case 'iec':
          return Assets.images.mainBackground.iecPreS.provider();

        default:
          return Assets.images.mainBackground.ukaPreS.provider();
      }
    } else {
      switch (schoolBrand) {
        case 'uka':
          return Assets.images.mainBackground.ukaHighS.provider();

        case 'ischool':
          return Assets.images.mainBackground.ischoolHighS.provider();

        case 'sna':
          return Assets.images.mainBackground.snaHighS.provider();

        case 'iec':
          return Assets.images.mainBackground.iecHighS.provider();

        default:
          return Assets.images.mainBackground.ukaHighS.provider();
      }
    }
  }

  ImageProvider<Object> brandLogo() {
    switch (schoolBrand) {
      case 'uka':
        return Assets.images.brandLogo.uka.provider();

      case 'ischool':
        return Assets.images.brandLogo.iSchool.provider();

      case 'sga':
        return Assets.images.brandLogo.sga.provider();

      case 'sna':
        return Assets.images.brandLogo.sna.provider();

      case 'iec':
        return Assets.images.brandLogo.iec.provider();

      default:
        return Assets.images.brandLogo.uka.provider();
    }
  }
}
