import 'package:flutter/material.dart';
import 'package:iportal2/resources/app_text_styles.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({required this.title, required this.update, this.cancell});
  final String title;
  final String update;
  final String? cancell;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style:
            AppTextStyles.normal18(fontWeight: FontWeight.w600, height: 0.09),
      ),
      surfaceTintColor: Colors.transparent,
      content: Column(
        children: [
          
        ],
      ),
    );
  }
}
