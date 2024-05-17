import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: const Color.fromARGB(152, 245, 245, 245),
      enabled: isLoading,
      child: child,
    );
  }
}

// Color.fromRGBO(242, 244, 247, 1),