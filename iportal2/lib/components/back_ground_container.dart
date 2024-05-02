 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/resources/assets.gen.dart';
import 'package:network_data_source/network_data_source.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final bgImage = state.user.mainBackGround();

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: bgImage,
            ),
          ),
          child: child,
        );
      },
    );
  }
}

extension UserBackGround on ProfileInfo {
  ImageProvider<Object> mainBackGround() {
    if (isKinderGarten()) {
      switch (school_brand) {
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
      switch (school_brand) {
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
    switch (school_brand) {
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
