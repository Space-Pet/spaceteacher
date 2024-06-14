import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/screens/observation_schedule/widgets/select_field.dart';

class CardFilterObservation extends StatelessWidget {
  const CardFilterObservation({
    super.key,
    required this.title,
    required this.typeField,
    this.options = const [],
    this.onDateChanged,
    this.onTeacherChanged,
  });
  final String title;
  final int typeField;
  final List<TeacherItem> options;
  final Function(DateTime)? onDateChanged;
  final Function(String)? onTeacherChanged;

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
          if (typeField == 1)
            SelectDate(
              onDateChanged: (date) {
                onDateChanged != null ? onDateChanged!(date) : null;
              },
            )
          else
            SelectField(
              typeField: typeField,
              options: options,
              onChanged: (value) {
                onTeacherChanged != null ? onTeacherChanged!(value) : null;
              },
            ),
          // const SizedBox(
          //   height: 10,
          // ),
          // if (typeField == 1) SelectDate(onDateChanged: (date) {}),
        ],
      ),
    );
  }
}
