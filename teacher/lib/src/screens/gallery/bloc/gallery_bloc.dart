import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/gallery_album_model.dart';
import 'package:teacher/repository/gallery_repository/gallery_repositories.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({required this.galleryRepository})
      : super(GalleryState(
          galleryAlbumModel: GalleryAlbumModel(),
          errorMessage: '',
        )) {
    on<GalleryGetListAlbum>(_onGetListAlbum);
  }

  final GalleryRepository galleryRepository;

  Future<void> _onGetListAlbum(
      GalleryGetListAlbum event, Emitter<GalleryState> emit) async {
    try {
      emit(state.copyWith(status: GalleryStatus.loading));
      final res = await galleryRepository.getListGallery(event.teacherId);
      emit(state.copyWith(
        galleryAlbumModel: res,
        status: GalleryStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: '$e',
        status: GalleryStatus.error,
      ));

      Log.e('$e',
          name: 'Get List Album Error GalleryBloc -> _onGetListAlbum()');
    }
  }
}
