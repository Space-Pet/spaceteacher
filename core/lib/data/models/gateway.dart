import 'package:json_annotation/json_annotation.dart';

part 'gateway.g.dart';

@JsonSerializable()
class Gateway {
  @JsonKey(name: 'url')
  final String? urlGateway;
  @JsonKey(name: 'is_webview')
  final int? isWebView;

  Gateway({
    this.urlGateway,
    this.isWebView,
  });

  factory Gateway.fromJson(Map<String, dynamic> json) =>
      _$GatewayFromJson(json);

  Map<String, dynamic> toJson() => _$GatewayToJson(this);

  @override
  String toString() {
    return 'Gateway{urlGatewat: $urlGateway, isWebView: $isWebView}';
  }

  Gateway copyWith({
    String? urlGateway,
    int? isWebView,
  }) {
    return Gateway(
      urlGateway: urlGateway ?? this.urlGateway,
      isWebView: isWebView ?? this.isWebView,
    );
  }
}
