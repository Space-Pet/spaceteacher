import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(GalleryState(albumData: AlbumData.fakeData)) {
    on<GalleryFetchData>(_onFetchAlbumData);
    on<GalleryUpdatePinnedAlbum>(_onUpdatePinnedAlbum);
    on<GalleryDelete>(_onDeleteAlbum);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  _onFetchAlbumData(GalleryFetchData event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    final user = currentUserBloc.state.user;

    final albumData = await appFetchApiRepo.getAlbum(
      user.teacher_id.toString(),
    );

    emit(state.copyWith(albumData: albumData, status: GalleryStatus.success));
  }

  _onUpdatePinnedAlbum(
      GalleryUpdatePinnedAlbum event, Emitter<GalleryState> emit) {
    final currentPinnedAlbum = currentUserBloc.state.user.pinnedAlbumIdList;
    final newPinnedAlbum = currentPinnedAlbum.contains(event.albumId)
        ? currentPinnedAlbum
            .where((element) => element != event.albumId)
            .toList()
        : [...currentPinnedAlbum, event.albumId];
    final newUser =
        currentUserBloc.state.user.copyWith(pinnedAlbumIdList: newPinnedAlbum);

    currentUserBloc.add(CurrentUserUpdated(user: newUser));
    userRepository.saveUser(newUser);
  }

  _onDeleteAlbum(GalleryDelete event, Emitter<GalleryState> emit) async {
    final res = await appFetchApiRepo.deleteAlbum(event.albumId);

    if (res['status'] == 'success') {
      emit(state.copyWith(status: GalleryStatus.deleteSuccess));
      add(GalleryFetchData());
    } else {
      emit(state.copyWith(
        error: res['message'],
        status: GalleryStatus.deleteFailure,
      ));
    }
  }
}
