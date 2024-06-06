part of 'gallery_bloc.dart';

enum GalleryStatus { init, loading, success, failure }

class GalleryState extends Equatable {
  const GalleryState({
    required this.albumData,
    this.status = GalleryStatus.init,
  });

  final AlbumData albumData;
  final GalleryStatus status;

  @override
  List<Object?> get props => [albumData, status];

  GalleryState copyWith({
    AlbumData? albumData,
    GalleryStatus? status,
  }) {
    return GalleryState(
      albumData: albumData ?? this.albumData,
      status: status ?? this.status,
    );
  }
}
