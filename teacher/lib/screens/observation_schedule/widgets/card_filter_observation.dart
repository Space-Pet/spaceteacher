import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/screens/observation_schedule/widgets/select_field.dart';

class CardFilterObservation extends StatelessWidget {
  const CardFilterObservation({
    required this.title,
    required this.typeField,
    super.key,
  });
  final String title;
  final int typeField;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: AppTextStyles.bold16(color: AppColors.blueForgorPassword),
          ),
          const SizedBox(
            height: 10,
          ),
          SelectField(typeField: typeField),
          if (typeField == 1)
            const SizedBox(
              height: 10,
            ),
          if (typeField == 1) SelectDate(onDateChanged: (date) {}),
        ],
      ),
    );
  }
}
