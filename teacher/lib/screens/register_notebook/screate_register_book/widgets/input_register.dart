import 'package:core/resources/app_colors.dart';
import 'package:core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class InputRegister extends StatelessWidget {
  const InputRegister({
    super.key,
    required this.note,
    required this.hintText,
    this.label = '',
    this.noLabel = false,
  });

  final Function(String note) note;
  final String hintText;
  final String label;
  final bool noLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!noLabel)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                label,
                style: AppTextStyles.normal14(
                  color: AppColors.gray700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          TextField(
            decoration: InputDecoration(
              constraints: const BoxConstraints(
                maxHeight: 44,
                minHeight: 44,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              labelText: hintText,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.gray300),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.gray300),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              hintStyle: AppTextStyles.normal12(),
            ),
            maxLines: null,
            onChanged: (value) {
              note(value);
            },
          ),
        ],
      ),
    );
  }
}
