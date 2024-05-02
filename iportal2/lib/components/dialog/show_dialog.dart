import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_colors.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog(
      {super.key,
      this.child,
      required this.title,
      this.onTap,
      required this.textConten,
      this.cancell});
  final String title;

  final String? cancell;
  final Widget? child;
  final String textConten;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          child!,
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.normal18(
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                  color: AppColors.gray500),
            ),
          ),
        ],
      ),
      surfaceTintColor: Colors.transparent,
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              textConten,
              style: AppTextStyles.normal14(color: AppColors.gray500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(AppColors.red90001),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(color: AppColors.red90001),
                  ),
                ),
                onPressed: onTap ?? () => Navigator.pop(context),
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      style: TextStyle(color: AppColors.white),
                      'Đóng',
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
