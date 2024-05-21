import 'package:json_annotation/json_annotation.dart';

part 'url_image_model.g.dart';

@JsonSerializable()
class UrlImageModel {
  final String? web;
  final String? mobile;

  factory UrlImageModel.fromJson(Map<String, dynamic> json) =>
      _$UrlImageModelFromJson(json);

  UrlImageModel({this.web, this.mobile});

  Map<String, dynamic> toJson() => _$UrlImageModelToJson(this);
}
