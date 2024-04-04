import 'package:json_annotation/json_annotation.dart';
part 'parent_model.g.dart';

@JsonSerializable()
class ParentModel {
  @JsonKey(name: 'parent_id')
  final int? parentID;
  @JsonKey(name: 'mother_name')
  final String? motherName;
  @JsonKey(name: 'mother_phone')
  final String? motherPhone;
  @JsonKey(name: 'father_name')
  final String? fatherName;
  @JsonKey(name: 'father_phone')
  final String? fatherPhone;

  ParentModel({
    this.parentID,
    this.motherName,
    this.motherPhone,
    this.fatherName,
    this.fatherPhone,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) =>
      _$ParentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParentModelToJson(this);

  @override
  String toString() {
    return 'ParentModel{parentID: $parentID, motherName: $motherName, motherPhone: $motherPhone, fatherName: $fatherName, fatherPhone: $fatherPhone}';
  }

  ParentModel copyWith({
    int? parentID,
    String? motherName,
    String? motherPhone,
    String? fatherName,
    String? fatherPhone,
  }) {
    return ParentModel(
      parentID: parentID ?? this.parentID,
      motherName: motherName ?? this.motherName,
      motherPhone: motherPhone ?? this.motherPhone,
      fatherName: fatherName ?? this.fatherName,
      fatherPhone: fatherPhone ?? this.fatherPhone,
    );
  }
}
