import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/gallery_model.dart';
part 'gallery_album_model.g.dart';

@JsonSerializable()
class GalleryAlbumModel {
  @JsonKey(name: 'items')
  final List<GalleryModel>? galleryAlbum;

  final int? total;
  final int? count;
  @JsonKey(name: 'per_page')
  final int? perPage;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_pages')
  final int? totalPages;

  GalleryAlbumModel(
      {this.galleryAlbum,
      this.total,
      this.count,
      this.perPage,
      this.currentPage,
      this.totalPages});

  factory GalleryAlbumModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryAlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryAlbumModelToJson(this);

  @override
  String toString() {
    return 'GalleryAlbumModel{galleryAlbum: $galleryAlbum, total: $total, count: $count, perPage: $perPage, currentPage: $currentPage, totalPages: $totalPages}';
  }

  GalleryAlbumModel copyWith({
    List<GalleryModel>? galleryAlbum,
    int? total,
    int? count,
    int? perPage,
    int? currentPage,
    int? totalPages,
  }) {
    return GalleryAlbumModel(
      galleryAlbum: galleryAlbum ?? this.galleryAlbum,
      total: total ?? this.total,
      count: count ?? this.count,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
