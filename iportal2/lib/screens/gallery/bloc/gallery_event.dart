part of 'gallery_bloc.dart';

@immutable
sealed class GalleryEvent {}

class GalleryFetchData extends GalleryEvent {
  GalleryFetchData();
}

class GalleryGetPinnedAlbumIdList extends GalleryEvent {
  GalleryGetPinnedAlbumIdList();
}

class GalleryUpdatePinnedAlbum extends GalleryEvent {
  GalleryUpdatePinnedAlbum(
    this.albumId,
  );

  final int albumId;
}
