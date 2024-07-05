part of 'gallery_detail_bloc.dart';

sealed class GalleryDetailEvent {}

class GalleryDetailFetchData extends GalleryDetailEvent {
  final int galleryId;

  GalleryDetailFetchData({required this.galleryId});
}

class GalleryDetailDelete extends GalleryDetailEvent {
  final int galleryId;

  GalleryDetailDelete({required this.galleryId});
}
