import 'package:flutter/material.dart';
import 'package:teacher/resources/resources.dart';

class DialogScaleAnimated extends StatefulWidget {
  const DialogScaleAnimated({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

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
              width: 300,
              height: 190,
              decoration: ShapeDecoration(
                color: AppColors.blueGray25,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppColors.grayD0,
                    ))),
                    child: Text(
                      widget.title,
                      style: AppTextStyles.custom(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Center(
                        child: Text(
                          widget.content,
                          textAlign: TextAlign.center,
                          style:
                              AppTextStyles.normal14(color: AppColors.gray800),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Đóng',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold14(
                              color: AppColors.brand600),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
