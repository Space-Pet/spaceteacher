import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/mark_model.dart';
import 'package:teacher/model/student_result_item_model.dart';
part 'student_result_model.g.dart';

@JsonSerializable()
class StudentResultModel {
  @JsonKey(name: 'items')
  final List<StudentResultItem>? studentResultItems;

  final String? comment;
  @JsonKey(name: 'teacher_name')
  final String? teacherName;

  @JsonKey(name: 'list_marks')
  final List<MarkModel>? listMarks;

  StudentResultModel({
    this.studentResultItems,
    this.comment,
    this.teacherName,
    this.listMarks,
  });

  factory StudentResultModel.fromJson(Map<String, dynamic> json) =>
      _$StudentResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentResultModelToJson(this);

  @override
  String toString() {
    return 'StudentResult{studentResultItems: $studentResultItems, comment: $comment, teacherName: $teacherName, listMarks: $listMarks}';
  }

  StudentResultModel copyWith({
    List<StudentResultItem>? studentResultItems,
    String? comment,
    String? teacherName,
    List<MarkModel>? listMarks,
  }) {
    return StudentResultModel(
      studentResultItems: studentResultItems ?? this.studentResultItems,
      comment: comment ?? this.comment,
      teacherName: teacherName ?? this.teacherName,
      listMarks: listMarks ?? this.listMarks,
    );
  }
}
