import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'gallery_create_state.dart';
part 'gallery_create_event.dart';

class GalleryCreateBloc extends Bloc<GalleryCreateEvent, GalleryCreateState> {
  GalleryCreateBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(GalleryCreateState(
          selectedClass: GalleryClass.empty(),
          selectedImages: [File('')],
        )) {
    on<GalleryCreateFetchListYear>(_onFetchListYear);
    add(GalleryCreateFetchListYear());
    on<GalleryCreateSelectYear>(_onSelectYear);

    on<GalleryCreateFetchListClass>(_onFetchListClass);
    on<GalleryCreateSelectClass>(_onSelectClass);

    on<GalleryCreateSelectImages>(_onSelectImg);
    on<GalleryRemovetImage>(_onRemoveImage);

    on<GalleryCreateNewGallery>(_onCreateNewGallery);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchListYear(GalleryCreateFetchListYear event,
      Emitter<GalleryCreateState> emit) async {
    emit(state.copyWith(status: GalleryCreateStatus.loadingClass));

    final listYear = await appFetchApiRepo.getListYear(1);
    emit(state.copyWith(listYear: listYear));

    if (listYear.isNotEmpty) {
      emit(state.copyWith(selectedYear: listYear.first));
      add(GalleryCreateFetchListClass());
    }
  }

  _onSelectYear(
      GalleryCreateSelectYear event, Emitter<GalleryCreateState> emit) {
    emit(state.copyWith(
      selectedYear: event.year,
      status: GalleryCreateStatus.loadingClass,
    ));
    add(GalleryCreateFetchListClass());
  }

  _onFetchListClass(GalleryCreateFetchListClass event,
      Emitter<GalleryCreateState> emit) async {
    final listClass = await appFetchApiRepo.getListClass(state.selectedYear);
    emit(state.copyWith(
      listClass: listClass,
      selectedClass: GalleryClass.empty(),
      status: GalleryCreateStatus.loadingClassSuccess,
    ));
  }

  _onSelectClass(
      GalleryCreateSelectClass event, Emitter<GalleryCreateState> emit) {
    final galleryClass = state.listClass.firstWhere(
      (element) => element.className == event.className,
    );

    emit(state.copyWith(selectedClass: galleryClass));
  }

  _onSelectImg(
      GalleryCreateSelectImages event, Emitter<GalleryCreateState> emit) {
    emit(state.copyWith(
      selectedImages: [...state.selectedImages, ...event.listImg],
    ));
  }

  _onRemoveImage(GalleryRemovetImage event, Emitter<GalleryCreateState> emit) {
    final newList = state.selectedImages
        .where(
            (element) => element.path != state.selectedImages[event.index].path)
        .toList();
    emit(state.copyWith(selectedImages: newList));
  }

  _onCreateNewGallery(
      GalleryCreateNewGallery event, Emitter<GalleryCreateState> emit) async {
    final listFiles = state.selectedImages
        .where((element) => element.path != '' && element.path != 'null')
        .toList();

    final res = await appFetchApiRepo.createNewAlbum(
      classId: state.selectedClass.classId,
      galleryName: event.name,
      learnYear: state.selectedYear,
      listFiles: listFiles,
      teacherId: currentUserBloc.state.user.teacher_id,
    );

    if (res['status'] == 'success') {
      emit(state.copyWith(
        selectedImages: [File('')],
        status: GalleryCreateStatus.createSuccess,
      ));
    } else {
      final errMsg = res['message'] ?? 'Có lỗi xảy ra, vui lòng thử lại sau';

      emit(state.copyWith(
        status: GalleryCreateStatus.createFailure,
        message: errMsg,
      ));
    }
  }
}
