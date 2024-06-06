part of 'gallery_bloc.dart';

sealed class GalleryEvent {}

class GalleryFetchData extends GalleryEvent {
  GalleryFetchData();
}

class GalleryUpdatePinnedAlbum extends GalleryEvent {
  final int albumId;

  GalleryUpdatePinnedAlbum({required this.albumId});
}
