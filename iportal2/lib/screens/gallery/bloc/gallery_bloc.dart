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
  }) : super(GalleryState(
          albumData: AlbumData.fakeData,
        )) {
    on<GalleryFetchData>(_onFetchAlbumData);
    add(GalleryFetchData());

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

  _onUpdatePinnedAlbum(
      GalleryUpdatePinnedAlbum event, Emitter<GalleryState> emit) {
    final currentPinnedAlbum =
        currentUserBloc.state.activeChild.pinnedAlbumIdList;

    final newPinnedAlbum = currentPinnedAlbum.contains(event.albumId)
        ? currentPinnedAlbum
            .where((element) => element != event.albumId)
            .toList()
        : [...currentPinnedAlbum, event.albumId];

    final newChildren = currentUserBloc.state.activeChild.copyWith(
      pinnedAlbumIdList: newPinnedAlbum,
      isActive: true,
    );

    final newChildrenList = currentUserBloc.state.user.children
        .map((e) => e.pupil_id == newChildren.pupil_id ? newChildren : e)
        .toList();

    final newUser =
        currentUserBloc.state.user.copyWith(children: newChildrenList);

    currentUserBloc.add(CurrentUserUpdated(user: newUser));
    userRepository.saveUser(newUser);
  }
}
