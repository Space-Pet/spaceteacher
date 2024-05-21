import 'package:json_annotation/json_annotation.dart';
part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel {
  @JsonKey(name: 'Subjet_Id')
  final int? subjectId;

  @JsonKey(name: 'Subject_Name')
  final String? subjectName;

  @JsonKey(name: 'tiet_num')
  final int? tietNum;
  @JsonKey(name: 'Class_Id')
  final int? classId;
  @JsonKey(name: 'Class_Name')
  final String? className;
  @JsonKey(name: 'Room')
  final String? room;
  @JsonKey(name: 'Teacher_Id')
  final int? teacherId;
  @JsonKey(name: 'Teacher_Name')
  final String? teacherName;
  @JsonKey(name: 'Teacher_Img')
  final String? teacherImg;

  SubjectModel({
    this.subjectId,
    this.subjectName,
    this.tietNum,
    this.classId,
    this.className,
    this.room,
    this.teacherId,
    this.teacherName,
    this.teacherImg,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);

  @override
  String toString() {
    return 'SubjectModel{subjectId: $subjectId, subjectName: $subjectName, tietNum: $tietNum, classId: $classId, className: $className, room: $room, teacherId: $teacherId, teacherName: $teacherName, teacherImg: $teacherImg}';
  }

  SubjectModel copyWith({
    int? subjectId,
    String? subjectName,
    int? tietNum,
    int? classId,
    String? className,
    String? room,
    int? teacherId,
    String? teacherName,
    String? teacherImg,
  }) {
    return SubjectModel(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      tietNum: tietNum ?? this.tietNum,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      room: room ?? this.room,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      teacherImg: teacherImg ?? this.teacherImg,
    );
  }
}
