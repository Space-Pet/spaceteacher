import 'package:json_annotation/json_annotation.dart';
part 'school_model.g.dart';

@JsonSerializable()
class SchoolModel {
  @JsonKey(name: 'school_id')
  final int? schoolID;
  final String? name;

  SchoolModel({
    this.schoolID,
    this.name,
  });

  factory SchoolModel.fromJson(Map<String, dynamic> json) =>
      _$SchoolModelFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolModelToJson(this);

  @override
  String toString() {
    return 'SchoolModel{schoolID: $schoolID, name: $name}';
  }

  SchoolModel copyWith({
    int? schoolID,
    String? name,
  }) {
    return SchoolModel(
      schoolID: schoolID ?? this.schoolID,
      name: name ?? this.name,
    );
  }
}
