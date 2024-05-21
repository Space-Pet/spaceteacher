import 'package:json_annotation/json_annotation.dart';
part 'class_model.g.dart';

@JsonSerializable()
class ClassModel {
  @JsonKey(name: 'class_id')
  final int? classID;
  final String? name;

  ClassModel({
    this.classID,
    this.name,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) =>
      _$ClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);

  @override
  String toString() {
    return 'ClassModel{classID: $classID, name: $name}';
  }

  ClassModel copyWith({
    int? classID,
    String? name,
  }) {
    return ClassModel(
      classID: classID ?? this.classID,
      name: name ?? this.name,
    );
  }
}
