import 'package:json_annotation/json_annotation.dart';

part 'payment_gateway.g.dart';

@JsonSerializable()
class PaymentGateway {
  @JsonKey(name: 'payment_id')
  final int? id;
  @JsonKey(name: 'payment_name')
  final String? name;
  final String? logo;
  @JsonKey(name: 'service_charge')
  final int? serviceCharge;

  PaymentGateway({
    this.id,
    this.name,
    this.logo,
    this.serviceCharge,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentGatewayToJson(this);

  @override
  String toString() {
    return 'PaymentGateway{id: $id, name : $name, logo: $logo, serviceCharge: $serviceCharge}';
  }

  PaymentGateway copyWith({
    int? id,
    String? name,
    String? logo,
    int? serviceCharge,
  }) {
    return PaymentGateway(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      serviceCharge: serviceCharge ?? this.serviceCharge,
    );
  }
}
