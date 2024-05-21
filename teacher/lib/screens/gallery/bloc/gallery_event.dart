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
  GalleryUpdatePinnedAlbum(this.pinnedAlbumIdList,
      {this.isOnlyUpdateState = false});

  final List<int> pinnedAlbumIdList;
  final bool isOnlyUpdateState;
}
