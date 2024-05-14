import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/url_image_model.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final int? id;
  final String? name;
  final String? description;
  @JsonKey(name: "images")
  final UrlImageModel? urlImageModel;
  final bool? isChoose;
  ImageModel(
      {this.id,
      this.name,
      this.description,
      this.urlImageModel,
      this.isChoose});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  @override
  String toString() {
    return 'ImageModel{id: $id, name: $name, description: $description, urlImageModel: $urlImageModel}';
  }

  ImageModel copyWith(
      {int? id,
      String? name,
      String? description,
      UrlImageModel? urlImageModel,
      bool? isChoose}) {
    return ImageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      urlImageModel: urlImageModel ?? this.urlImageModel,
      isChoose: isChoose ?? this.isChoose,
    );
  }
}
