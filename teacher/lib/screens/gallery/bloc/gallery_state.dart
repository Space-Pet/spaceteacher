part of 'gallery_bloc.dart';

enum GalleryStatus { init, loading, success, failure }

class GalleryState extends Equatable {
  const GalleryState({
    required this.albumData,
    this.status = GalleryStatus.init,
    this.pinnedAlbumIdList = const [],
  });

  final List<int> pinnedAlbumIdList;
  final AlbumData albumData;
  final GalleryStatus status;

  @override
  List<Object?> get props => [albumData, pinnedAlbumIdList, status];

  GalleryState copyWith({
    AlbumData? albumData,
    GalleryStatus? status,
    List<int>? pinnedAlbumIdList,
  }) {
    return GalleryState(
      albumData: albumData ?? this.albumData,
      status: status ?? this.status,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
    );
  }
}
