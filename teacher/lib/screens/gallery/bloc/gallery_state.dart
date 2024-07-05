part of 'gallery_bloc.dart';

enum GalleryStatus { init, loading, success, failure, deleteSuccess, deleteFailure }

class GalleryState extends Equatable {
  const GalleryState({
    required this.albumData,
    this.status = GalleryStatus.init,
    this.error,
  });

  final AlbumData albumData;
  final GalleryStatus status;
  final String? error;

  @override
  List<Object?> get props => [albumData, status, error];

  GalleryState copyWith({
    AlbumData? albumData,
    GalleryStatus? status,
    String? error,
  }) {
    return GalleryState(
      albumData: albumData ?? this.albumData,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
