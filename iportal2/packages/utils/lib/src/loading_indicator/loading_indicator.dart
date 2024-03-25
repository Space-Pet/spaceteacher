import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(
      {super.key, this.size = 50, this.androidColor = Colors.blue});
  final double size;
  final Color androidColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : SpinKitFadingCircle(
              color: androidColor,
              size: size,
            ),
    );
  }
}
