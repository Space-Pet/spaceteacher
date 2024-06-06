import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(GalleryState(albumData: AlbumData.empty)) {
    on<GalleryFetchData>(_onFetchAlbumData);
    add(GalleryFetchData());

    on<GalleryGetPinnedAlbumIdList>(_onGetPinnedAlbumIdList);
    add(GalleryGetPinnedAlbumIdList());

    on<GalleryUpdatePinnedAlbum>(_onUpdatePinnedAlbum);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  _onFetchAlbumData(GalleryFetchData event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    final user = currentUserBloc.state.activeChild;

    final albumData = await appFetchApiRepo.getAlbum(
      // pupilId: '10044568',
      pupilId: user.pupil_id.toString(),
    );
    emit(state.copyWith(
      albumData: albumData,
      status: GalleryStatus.success,
    ));
  }

  _onGetPinnedAlbumIdList(
      GalleryGetPinnedAlbumIdList event, Emitter<GalleryState> emit) async {
    if (currentUserBloc.state.activeChild.isMN) {
      final user = currentUserBloc.state.activeChild;

      emit(state.copyWith(pinnedAlbumIdList: user.pinnedAlbumIdList));
    }
  }

  _onUpdatePinnedAlbum(
      GalleryUpdatePinnedAlbum event, Emitter<GalleryState> emit) {
    if (!event.isOnlyUpdateState) {
      final user = currentUserBloc.state.activeChild;
      // TODO: update pinned album
    }

    emit(state.copyWith(pinnedAlbumIdList: event.pinnedAlbumIdList));
  }
}
