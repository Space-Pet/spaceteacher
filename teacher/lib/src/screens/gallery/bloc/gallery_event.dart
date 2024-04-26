part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class GalleryGetListAlbum extends GalleryEvent {
  final int teacherId;

  const GalleryGetListAlbum({required this.teacherId});
  @override
  List<Object?> get props => [teacherId];
}

class GalleryCreateAlbum extends GalleryEvent {}
