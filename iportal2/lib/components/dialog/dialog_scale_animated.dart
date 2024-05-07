import 'package:flutter/material.dart';
import 'package:core/resources/resources.dart';

class DialogScaleAnimated extends StatefulWidget {
  const DialogScaleAnimated({
    super.key,
    required this.dialogContent,
  });

  final Widget dialogContent;

  @override
  State<StatefulWidget> createState() => DialogScaleAnimatedState();
}

class DialogScaleAnimatedState extends State<DialogScaleAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
              color: AppColors.blueGray25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.dialogContent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
