import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class InstructrionSkeleton extends StatelessWidget {
  const InstructrionSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SkeletonItem(
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(width: double.infinity),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
