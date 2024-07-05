import 'package:json_annotation/json_annotation.dart';

part 'class_teacher.g.dart';

@JsonSerializable()
class ClassTeacher {
  @JsonKey(name: 'class_id')
  final int classId;

  @JsonKey(name: 'grade_id')
  final int gradeId;

  @JsonKey(name: 'school_id')
  final int schoolId;

  @JsonKey(name: 'class_name')
  final String className;

  @JsonKey(name: 'grade_title')
  final String gradeTitle;

  final String title;

  final String code;

  final String level;

  @JsonKey(name: 'room_id')
  final int roomId;

  @JsonKey(name: 'room_title')
  final String? roomTitle;

  final String? selected;

  ClassTeacher({
    required this.classId,
    required this.gradeId,
    required this.schoolId,
    required this.className,
    required this.gradeTitle,
    required this.title,
    required this.code,
    required this.level,
    required this.roomId,
    this.roomTitle = '',
    this.selected = '',
  });

  factory ClassTeacher.fromJson(Map<String, dynamic> json) =>
      _$ClassTeacherFromJson(json);

  Map<String, dynamic> toJson() => _$ClassTeacherToJson(this);

  static ClassTeacher empty() => ClassTeacher(
        classId: 0,
        gradeId: 0,
        schoolId: 0,
        className: '',
        gradeTitle: '',
        title: '',
        code: '',
        level: '',
        roomId: 0,
        roomTitle: '',
        selected: '',
      );
}
