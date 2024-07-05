import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'gallery_detail_event.dart';
part 'gallery_detail_state.dart';

class GalleryDetailBloc extends Bloc<GalleryDetailEvent, GalleryDetailState> {
  GalleryDetailBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(GalleryDetailState(
          albumDetail: Gallery.fakeData(),
        )) {
    on<GalleryDetailFetchData>(_onFetchAlbumData);
    on<GalleryDetailDelete>(_onDeleteAlbum);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  _onFetchAlbumData(
      GalleryDetailFetchData event, Emitter<GalleryDetailState> emit) async {
    emit(state.copyWith(status: GalleryDetailStatus.loading));

    final user = currentUserBloc.state.user;

    final albumData = await appFetchApiRepo.getGalleryDetail(
      user.teacher_id.toString(),
      event.galleryId,
    );

    emit(state.copyWith(
      albumDetail: albumData,
      status: GalleryDetailStatus.success,
    ));
  }

  _onDeleteAlbum(
      GalleryDetailDelete event, Emitter<GalleryDetailState> emit) async {
    final res = await appFetchApiRepo.deleteAlbum(event.galleryId);

    if (res['status'] == 'success') {
      emit(state.copyWith(status: GalleryDetailStatus.deleteSuccess));
    } else {
      emit(state.copyWith(
        error: res['message'],
        status: GalleryDetailStatus.deleteFailure,
      ));
    }
  }
}
