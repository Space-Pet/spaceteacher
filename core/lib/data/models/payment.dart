import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class PaymentItem {
  int? order;
  String? cost;
  int? total;
  @JsonKey(name: 'type_costs')
  String? typeCosts;

  PaymentItem({
    this.order,
    this.cost,
    this.total,
    this.typeCosts,
  });

  factory PaymentItem.fromJson(Map<String, dynamic> json) =>
      _$PaymentItemFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentItemToJson(this);
}
