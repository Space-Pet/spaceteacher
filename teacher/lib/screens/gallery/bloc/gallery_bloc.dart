import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
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

    final user = currentUserBloc.state.user;

    final albumData = await appFetchApiRepo.getAlbum(
      user.teacher_id.toString(),
    );
    emit(state.copyWith(
      albumData: albumData,
      status: GalleryStatus.success,
    ));
  }

  _onGetPinnedAlbumIdList(
      GalleryGetPinnedAlbumIdList event, Emitter<GalleryState> emit) async {
    if (currentUserBloc.state.user.isKinderGarten) {
      final user = currentUserBloc.state.user;
      final featuresLocal = await userRepository.getLoggedUsers();

      final pinnedAlbumIdList = featuresLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LoggedUser.empty(),
          )
          .pinnedAlbumIdList;
      emit(state.copyWith(pinnedAlbumIdList: pinnedAlbumIdList));
    }
  }

  _onUpdatePinnedAlbum(
      GalleryUpdatePinnedAlbum event, Emitter<GalleryState> emit) {
    if (!event.isOnlyUpdateState) {
      final user = currentUserBloc.state.user;
      userRepository.updatePinnedAlbum(event.pinnedAlbumIdList, user.user_key);
    }

    emit(state.copyWith(pinnedAlbumIdList: event.pinnedAlbumIdList));
  }
}
