import 'package:core/core.dart';
import 'package:core/data/models/violation_data.dart';
import 'package:core/data/models/weeky_lesson.dart';
import 'package:core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DropdownButtonComponent extends StatefulWidget {
  final List<LessonRank> optionList;
  final String hint;
  final ValueChanged<LessonRank> onUpdateOption;

  const DropdownButtonComponent({
    Key? key,
    required this.optionList,
    required this.hint,
    required this.onUpdateOption,
  }) : super(key: key);

  @override
  _DropdownButtonComponentState createState() =>
      _DropdownButtonComponentState();
}

class _DropdownButtonComponentState extends State<DropdownButtonComponent> {
  LessonRank? selectedStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.gray100,
        border: Border.all(color: AppColors.gray300), // Add border if needed
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LessonRank>(
          isExpanded: true,
          hint: Text(widget.hint),
          value: selectedStudent,
          onChanged: (LessonRank? newValue) {
            setState(() {
              selectedStudent = newValue!;
            });
            widget.onUpdateOption(newValue!);
          },
          items: widget.optionList
              .map<DropdownMenuItem<LessonRank>>((LessonRank student) {
            return DropdownMenuItem<LessonRank>(
              value: student,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(student.lessonRankName),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DropdownButtonRegister extends StatefulWidget {
  final List<PupilInfo>? pupilInfo;
  final List<ListViolation>? listViolation;
  final String hint;
  final ValueChanged<PupilInfo>? onUpdateOption;
  final ValueChanged<ListViolation>? onUpdateViolation;

  const DropdownButtonRegister({
    Key? key,
    this.listViolation,
    this.pupilInfo,
    required this.hint,
    this.onUpdateOption,
    this.onUpdateViolation,
  }) : super(key: key);

  @override
  _DropdownButtonRegisterState createState() => _DropdownButtonRegisterState();
}

class _DropdownButtonRegisterState extends State<DropdownButtonRegister> {
  PupilInfo? selectedStudent;
  ListViolation? selectedViolation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: widget.pupilInfo != null && widget.pupilInfo!.isNotEmpty
            ? DropdownButton<PupilInfo>(
                isExpanded: true,
                hint: Text(widget.hint),
                value: selectedStudent,
                onChanged: (PupilInfo? newValue) {
                  setState(() {
                    selectedStudent = newValue;
                  });
                  if (widget.onUpdateOption != null) {
                    widget.onUpdateOption!(newValue!);
                  }
                },
                items: widget.pupilInfo!
                    .map<DropdownMenuItem<PupilInfo>>((PupilInfo student) {
                  return DropdownMenuItem<PupilInfo>(
                    value: student,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(student.pupilName),
                    ),
                  );
                }).toList(),
              )
            : DropdownButton<ListViolation>(
                isExpanded: true,
                hint: Text(widget.hint),
                value: selectedViolation,
                onChanged: (ListViolation? newValue) {
                  setState(() {
                    selectedViolation = newValue;
                  });
                  if (widget.onUpdateViolation != null) {
                    widget.onUpdateViolation!(newValue!);
                  }
                },
                items: widget.listViolation!
                    .map<DropdownMenuItem<ListViolation>>(
                        (ListViolation violation) {
                  return DropdownMenuItem<ListViolation>(
                    value: violation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(violation.viPhamName),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
