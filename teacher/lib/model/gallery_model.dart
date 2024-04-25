import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/image_model.dart';
part 'gallery_model.g.dart';

@JsonSerializable()
class GalleryModel {
  @JsonKey(name: 'gallery_id')
  final int? id;
  @JsonKey(name: 'gallery_name')
  final String? name;
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'school_id')
  final int? schoolId;
  @JsonKey(name: 'gallery_number')
  final int? galleryNumber;
  @JsonKey(name: 'gallery_images')
  final List<ImageModel>? images;

  GalleryModel(
      {this.id,
      this.name,
      this.learnYear,
      this.schoolId,
      this.galleryNumber,
      this.images});

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);

  @override
  String toString() {
    return 'GalleryModel{id: $id, name: $name, learnYear: $learnYear, schoolId: $schoolId, galleryNumber: $galleryNumber, images: $images}';
  }

  GalleryModel copyWith({
    int? id,
    String? name,
    String? learnYear,
    int? schoolId,
    int? galleryNumber,
    List<ImageModel>? images,
  }) {
    return GalleryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      learnYear: learnYear ?? this.learnYear,
      schoolId: schoolId ?? this.schoolId,
      galleryNumber: galleryNumber ?? this.galleryNumber,
      images: images ?? this.images,
    );
  }
}
