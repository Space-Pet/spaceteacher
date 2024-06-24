import 'package:core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class InputRegister extends StatelessWidget {
  const InputRegister({
    super.key,
    required this.note,
    required this.labalText,
  });

  final Function(String note) note;
  final String labalText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: AppColors.gray300)),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              border: InputBorder.none,
              labelText: labalText),
          maxLines: null,
          onChanged: (value) {
            note(value);
          },
        ),
      ),
    );
  }
}