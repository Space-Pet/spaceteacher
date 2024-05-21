part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, loaded, error }

class GalleryState extends Equatable {
  const GalleryState({
    required this.galleryAlbumModel,
    required this.errorMessage,
    this.status = GalleryStatus.initial,
  });

  final GalleryAlbumModel galleryAlbumModel;
  final String errorMessage;
  final GalleryStatus status;

  GalleryState copyWith({
    GalleryAlbumModel? galleryAlbumModel,
    String? errorMessage,
    GalleryStatus? status,
  }) {
    return GalleryState(
      galleryAlbumModel: galleryAlbumModel ?? this.galleryAlbumModel,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        galleryAlbumModel,
        errorMessage,
        status,
      ];
}
