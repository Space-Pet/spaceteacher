import 'package:flutter/material.dart';

import '../theme/theme_color.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeColor.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: 30,
      ),
      child: child,
    );
  }
}
