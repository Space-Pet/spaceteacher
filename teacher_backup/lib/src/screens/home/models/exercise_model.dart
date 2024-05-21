import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';

@JsonSerializable()
class ExerciseModel {
  final int? id;
  final int? number;
  final String? subjectname;
  final String? name;
  final String? teacherAva;
  final String? description;
  final String? duetime;
  final String? duedate;
  final String? fileUrl;
  final String? fileName;

  ExerciseModel({
    this.id,
    this.number,
    this.subjectname,
    this.name,
    this.teacherAva,
    this.description,
    this.duetime,
    this.duedate,
    this.fileUrl,
    this.fileName,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  ExerciseModel copyWith({
    int? id,
    int? number,
    String? subjectname,
    String? name,
    String? teacherAva,
    String? description,
    String? duetime,
    String? duedate,
    String? fileUrl,
    String? fileName,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      number: number ?? this.number,
      subjectname: subjectname ?? this.subjectname,
      name: name ?? this.name,
      teacherAva: teacherAva ?? this.teacherAva,
      description: description ?? this.description,
      duetime: duetime ?? this.duetime,
      duedate: duedate ?? this.duedate,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  String toString() {
    return 'ExerciseModel(id: $id, number: $number, subjectname: $subjectname, name: $name, teacherAva: $teacherAva, description: $description, duetime: $duetime, duedate: $duedate, fileUrl: $fileUrl, fileName: $fileName)';
  }
}
