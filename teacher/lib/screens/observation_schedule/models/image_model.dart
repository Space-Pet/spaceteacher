import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/screens/observation_schedule/models/url_image_model.dart';
part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final int? id;
  final String? name;
  final String? description;
  @JsonKey(name: "images")
  final UrlImageModel? urlImageModel;

  ImageModel({this.id, this.name, this.description, this.urlImageModel});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  @override
  String toString() {
    return 'ImageModel{id: $id, name: $name, description: $description, urlImageModel: $urlImageModel}';
  }

  ImageModel copyWith({
    int? id,
    String? name,
    String? description,
    UrlImageModel? urlImageModel,
  }) {
    return ImageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      urlImageModel: urlImageModel ?? this.urlImageModel,
    );
  }
}
