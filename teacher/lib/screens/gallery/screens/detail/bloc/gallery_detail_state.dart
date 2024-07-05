part of 'gallery_detail_bloc.dart';

enum GalleryDetailStatus {
  init,
  loading,
  success,
  failure,
  deleteSuccess,
  deleteFailure
}

class GalleryDetailState extends Equatable {
  const GalleryDetailState({
    required this.albumDetail,
    this.status = GalleryDetailStatus.init,
    this.error,
  });

  final Gallery albumDetail;
  final GalleryDetailStatus status;
  final String? error;

  @override
  List<Object?> get props => [albumDetail, status, error];

  GalleryDetailState copyWith({
    Gallery? albumDetail,
    GalleryDetailStatus? status,
    String? error,
  }) {
    return GalleryDetailState(
      albumDetail: albumDetail ?? this.albumDetail,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
