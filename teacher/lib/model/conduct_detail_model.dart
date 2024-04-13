import 'package:json_annotation/json_annotation.dart';
part 'conduct_detail_model.g.dart';

@JsonSerializable()
class ConductDetailModel {
  @JsonKey(name: 'item_id')
  final String? itemId;
  @JsonKey(name: 'item_name')
  final String? itemName;
  @JsonKey(name: 'hanh_kiem_result')
  final String? hanhKiemResult;
  @JsonKey(name: 'hanh_kiem_name')
  final String? hanhKiemName;

  ConductDetailModel({
    this.itemId,
    this.itemName,
    this.hanhKiemResult,
    this.hanhKiemName,
  });

  factory ConductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ConductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConductDetailModelToJson(this);

  @override
  String toString() {
    return 'ConductDetailModel{itemId: $itemId, itemName: $itemName, hanhKiemResult: $hanhKiemResult, hanhKiemName: $hanhKiemName}';
  }

  ConductDetailModel copyWith({
    String? itemId,
    String? itemName,
    String? hanhKiemResult,
    String? hanhKiemName,
  }) {
    return ConductDetailModel(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      hanhKiemResult: hanhKiemResult ?? this.hanhKiemResult,
      hanhKiemName: hanhKiemName ?? this.hanhKiemName,
    );
  }
}
