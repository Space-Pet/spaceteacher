part of 'gallery_create_bloc.dart';

sealed class GalleryCreateEvent {}

class GalleryCreateFetchData extends GalleryCreateEvent {
  GalleryCreateFetchData();
}

class GalleryCreateFetchListYear extends GalleryCreateEvent {
  GalleryCreateFetchListYear();
}

class GalleryCreateSelectYear extends GalleryCreateEvent {
  GalleryCreateSelectYear({required this.year});

  final String year;
}

class GalleryCreateFetchListClass extends GalleryCreateEvent {
  GalleryCreateFetchListClass();
}

class GalleryCreateSelectClass extends GalleryCreateEvent {
  GalleryCreateSelectClass({required this.className});

  final String className;
}

class GalleryCreateSelectImages extends GalleryCreateEvent {
  GalleryCreateSelectImages({required this.listImg});

  final List<File> listImg;
}

class GalleryRemovetImage extends GalleryCreateEvent {
  GalleryRemovetImage({required this.index});

  final int index;
}

class GalleryCreateNewGallery extends GalleryCreateEvent {
  final String name;

  GalleryCreateNewGallery({required this.name});
}
