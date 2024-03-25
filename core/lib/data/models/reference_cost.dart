import 'package:json_annotation/json_annotation.dart';

part 'reference_cost.g.dart';

@JsonSerializable(explicitToJson: true)
class ReferenceCost {
  String? id;
  String? name;
  String? status;
  double? value;

  ReferenceCost({this.id, this.name, this.status, this.value});

  factory ReferenceCost.fromJson(Map<String, dynamic> json) =>
      _$ReferenceCostFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceCostToJson(this);
}
