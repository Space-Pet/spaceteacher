import 'package:core/core.dart';
import 'package:flutter/material.dart';

class DialogViewExercise extends StatefulWidget {
  const DialogViewExercise({
    super.key,
    required this.title,
    required this.content,
    this.isLink = false,
    this.link = '',
  });

  final String title;
  final String content;
  final bool isLink;
  final String link;

  @override
  State<StatefulWidget> createState() => DialogViewExerciseState();
}

class DialogViewExerciseState extends State<DialogViewExercise>
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
                      child: InkWell(
                        onTap: () async {
                          launchUrl(
                            Uri.parse(widget.link),
                            mode: LaunchMode.inAppBrowserView,
                          );
                        },
                        child: Center(
                          child: Text(
                            widget.content,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.normal14(
                                color: widget.isLink
                                    ? AppColors.brand600
                                    : AppColors.gray800),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 50,
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
