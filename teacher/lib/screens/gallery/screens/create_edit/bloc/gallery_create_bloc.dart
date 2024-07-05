import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:http/http.dart' as http;

part 'gallery_create_state.dart';
part 'gallery_create_event.dart';

class GalleryCreateBloc extends Bloc<GalleryCreateEvent, GalleryCreateState> {
  GalleryCreateBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(GalleryCreateState(
          selectedClass: GalleryClass.empty(),
          selectedImages: [File('')],
          albumDetail: Gallery.empty,
        )) {
    on<GalleryCreateFetchListYear>(_onFetchListYear);
    add(GalleryCreateFetchListYear());

    on<GalleryCreateSelectYear>(_onSelectYear);

    on<GalleryCreateFetchListClass>(_onFetchListClass);

    on<GalleryCreateSelectClass>(_onSelectClass);

    on<GalleryCreateSelectImages>(_onSelectImg);
    on<GalleryRemovetImage>(_onRemoveImage);

    on<GalleryCreateNewGallery>(_onCreateNewGallery);

    on<GalleryEditSetValues>(_onSetValues);
    on<GalleryDeteleImages>(_ondeleteImagesInGallery);

    on<GalleryUpdate>(_onUpdateGallery);
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

  _onSetValues(
      GalleryEditSetValues event, Emitter<GalleryCreateState> emit) async {
    emit(state.copyWith(status: GalleryCreateStatus.loadingSetValues));
    final listClass =
        await appFetchApiRepo.getListClass(event.albumDetail.learnYear);

    final albumDetail = event.albumDetail;
    final galleryClass = listClass.firstWhere(
      (element) => element.classId == event.albumDetail.classId,
    );

    final imageFiles =
        await Future.wait(albumDetail.galleryImages.map((image) async {
      final response = await http.get(Uri.parse(image.images.mobile));
      final bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${image.id}.${image.name})');
      await file.writeAsBytes(bytes);
      return file;
    }).toList());

    emit(state.copyWith(
      albumDetail: event.albumDetail,
      selectedYear: event.albumDetail.learnYear,
      selectedClass: galleryClass,
      selectedImages: [...state.selectedImages, ...imageFiles],
      initImages: imageFiles,
      status: GalleryCreateStatus.successSetValues,
    ));
  }

  Future _ondeleteImagesInGallery(
      GalleryDeteleImages event, Emitter<GalleryCreateState> emit) async {
    final res = await appFetchApiRepo.deleteImagesInGallery(
      galleryId: event.albumId,
      listId: event.listId,
    );

    if (res['status'] == 'success') {
      emit(state.copyWith(
        status: GalleryCreateStatus.deleteImagesSuccess,
      ));
    } else {
      emit(state.copyWith(
        status: GalleryCreateStatus.deleteImagesFailure,
        message: res['message'],
      ));
    }
  }

  _onUpdateGallery(
      GalleryUpdate event, Emitter<GalleryCreateState> emit) async {
    emit(state.copyWith(status: GalleryCreateStatus.updateLoading));
    List<File> listFilesUpdated = [];
    final galleryClass = state.listClass.firstWhere(
      (element) => element.classId == state.albumDetail.classId,
    );

    final listImage = state.selectedImages
        .where((element) => element.path != '' && element.path != 'null')
        .toList();

    final initImages = state.initImages;

    for (final image in listImage) {
      final isExisting =
          initImages.any((attachment) => attachment.path == image.path);
      if (!isExisting) {
        listFilesUpdated.add(image);
      }
    }

    List<int> listIdRemoved = [];
    for (final image in initImages) {
      final isRemoved = listImage.every((file) => file.path != image.path);
      if (isRemoved) {
        final imageId = image.path.split('/').last.split('.').first;
        listIdRemoved.add(int.parse(imageId));
      }
    }
    if (listIdRemoved.isNotEmpty) {
      final res = await appFetchApiRepo.deleteImagesInGallery(
        galleryId: event.galleryId,
        listId: listIdRemoved,
      );

      if (res['status'] == 'success') {
        emit(state.copyWith(
          status: GalleryCreateStatus.deleteImagesSuccess,
        ));
      } else {
        emit(state.copyWith(
          status: GalleryCreateStatus.deleteImagesFailure,
          message: res['message'],
          selectedImages: [File(''), ...initImages],
          selectedClass: galleryClass,
          selectedYear: state.albumDetail.learnYear,
        ));
        return;
      }
    }

    final res = await appFetchApiRepo.updateGallery(
      listFiles: listFilesUpdated,
      classId: state.selectedClass.classId,
      learnYear: state.selectedYear,
      galleryId: event.galleryId,
      galleryName: event.name,
    );

    if (res['status'] == 'success') {
      emit(state.copyWith(
        status: GalleryCreateStatus.updateSuccess,
      ));
    } else {
      emit(state.copyWith(
        status: GalleryCreateStatus.updateFailure,
        message: res['message'],
      ));
    }
  }
}
