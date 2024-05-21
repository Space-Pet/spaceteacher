import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/conduct_detail_model.dart';
part 'conduct_model.g.dart';

@JsonSerializable()
class ConductModel {
  @JsonKey(name: 'hanh_kiem_value')
  final List<ConductDetailModel> hanhKiemValue;

  ConductModel({
    required this.hanhKiemValue,
  });

  factory ConductModel.fromJson(Map<String, dynamic> json) =>
      _$ConductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConductModelToJson(this);

  @override
  String toString() {
    return 'ConductModel{hanhKiemValue: $hanhKiemValue}';
  }

  ConductModel copyWith({
    List<ConductDetailModel>? hanhKiemValue,
  }) {
    return ConductModel(
      hanhKiemValue: hanhKiemValue ?? this.hanhKiemValue,
    );
  }
}
