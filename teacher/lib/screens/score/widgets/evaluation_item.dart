import 'package:core/resources/resources.dart';
import 'package:flutter/material.dart';

class StudentEvaluationItem extends StatefulWidget {
  const StudentEvaluationItem({
    super.key,
    this.label,
    this.result,
    this.isLast = false,
  });

  final String? label;
  final String? result;
  final bool isLast;

  @override
  _StudentEvaluationItemState createState() => _StudentEvaluationItemState();
}

class _StudentEvaluationItemState extends State<StudentEvaluationItem> {
  String? selectedResult;

  @override
  void initState() {
    super.initState();
    selectedResult = widget.result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
          border: widget.isLast
              ? Border.all(color: Colors.transparent)
              : const Border(bottom: BorderSide(color: AppColors.gray300))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label ?? 'Chăm học',
              style: AppTextStyles.normal14(color: AppColors.gray600)),
          widget.result == null
              ? DropdownButton<String>(
                  value: selectedResult,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: AppTextStyles.bold14(color: AppColors.brand600),
                  underline: Container(
                    height: 2,
                    color: AppColors.brand600,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedResult = newValue;
                    });
                  },
                  items: <String>['T', 'Đ', 'K']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              : Text(
                  widget.result ?? ' T',
                  style: AppTextStyles.bold14(color: AppColors.brand600),
                )
        ],
      ),
    );
  }
}
