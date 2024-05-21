import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel {
  final int? id;
  final int? number;
  final String? name;
  final String? teacherName;
  final String? teacherAva;
  final String? description;
  final String? timeStart;
  final String? timeEnd;
  final String? advice;
  final String? fileUrl;
  final String? attendance;
  final String? room;

  LessonModel(
      {this.id,
      this.number,
      this.name,
      this.teacherName,
      this.teacherAva,
      this.description,
      this.timeStart,
      this.timeEnd,
      this.advice,
      this.fileUrl,
      this.attendance,
      this.room});

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  LessonModel copyWith({
    int? id,
    int? number,
    String? name,
    String? teacherName,
    String? teacherAva,
    String? description,
    String? timeStart,
    String? timeEnd,
    String? advice,
    String? fileUrl,
    String? attendance,
    String? room,
  }) {
    return LessonModel(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      teacherName: teacherName ?? this.teacherName,
      teacherAva: teacherAva ?? this.teacherAva,
      description: description ?? this.description,
      timeStart: timeStart ?? this.timeStart,
      timeEnd: timeEnd ?? this.timeEnd,
      advice: advice ?? this.advice,
      fileUrl: fileUrl ?? this.fileUrl,
      attendance: attendance ?? this.attendance,
      room: room ?? this.room,
    );
  }

  @override
  String toString() {
    return 'LessonModel(id: $id, number: $number, name: $name, teacherName: $teacherName, teacherAva: $teacherAva, description: $description, timeStart: $timeStart, timeEnd: $timeEnd, advice: $advice, fileUrl: $fileUrl, attendance: $attendance, room: $room)';
  }
}
