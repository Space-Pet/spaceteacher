import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/notifications/bloc/notification_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(HomeState(
          exerciseDueDateToday: const [],
          exerciseDueDateDataList: const [],
          exerciseInDayDataList: const [],
          notificationData: NotificationData.empty(),
          albumData: AlbumData.empty,
          datePicked: DateTime.now(),
        )) {
    on<HomeFetchExercise>(_onFetchExercise);
    add(HomeFetchExercise());
    on<HomeExerciseSelectDate>(_onSelectDate);

    on<HomeFetchNotificationData>(_onFetchNotifications);
    add(HomeFetchNotificationData());

    on<HomeFetchAlbumData>(_onFetchAlbumData);
    add(HomeFetchAlbumData());

    on<HomeGetPinnedAlbumIdList>(_onGetPinnedAlbumIdList);
    add(HomeGetPinnedAlbumIdList());
    on<HomeUpdatePinnedAlbum>(_onUpdatePinnedAlbum);

    on<HomeRefresh>(_onRefresh);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  _onSelectDate(HomeExerciseSelectDate event, Emitter<HomeState> emit) async {
    emit(state.copyWith(statusExercise: HomeStatus.loading));

    final exerciseDueDateDataList = await appFetchApiRepo.getExercises(
      // userKey: currentUserBloc.state.user.user_key,
      datePicked: event.datePicked,
      userKey: '0723210020',
    );

    emit(
      state.copyWith(exerciseDueDateDataList: exerciseDueDateDataList),
    );

    final exerciseInDayDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      datePicked: event.datePicked,
      isDueDate: false,
    );
    emit(
      state.copyWith(
        exerciseInDayDataList: exerciseInDayDataList,
        datePicked: event.datePicked,
        statusExercise: HomeStatus.success,
      ),
    );
  }

  _onFetchExercise(HomeFetchExercise event, Emitter<HomeState> emit) async {
    if (!currentUserBloc.state.user.isKinderGarten()) {
      emit(state.copyWith(statusExercise: HomeStatus.loading));

      final exerciseDataList = await appFetchApiRepo.getExercises(
        userKey: currentUserBloc.state.user.user_key,
        datePicked: DateTime.now(),
        isDueDate: event.isDueDate,
        // txtDate: '18-03-2024',
        // userKey: '0723210020',
      );

      if (event.isDueDate) {
        emit(
          state.copyWith(
            exerciseDueDateToday: exerciseDataList,
            exerciseDueDateDataList: exerciseDataList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            exerciseInDayDataList: exerciseDataList,
          ),
        );
      }

      emit(state.copyWith(statusExercise: HomeStatus.success));
    }
  }

  _onFetchNotifications(
      HomeFetchNotificationData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(statusNoti: HomeStatus.loading));

    final user = currentUserBloc.state.user;
    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_brand,
    };

    final notificationData = await appFetchApiRepo.getNotifications(
      headers: headers,
      viewed: 0,
      orderBy: NotificationOrderBy.desc.value,
    );
    emit(state.copyWith(
        notificationData: notificationData, statusNoti: HomeStatus.success));
  }

  _onFetchAlbumData(HomeFetchAlbumData event, Emitter<HomeState> emit) async {
    if (currentUserBloc.state.user.isKinderGarten()) {
      emit(state.copyWith(statusAlbum: HomeStatus.loading));

      final user = currentUserBloc.state.user;

      final albumData = await appFetchApiRepo.getAlbum(
        // pupilId: '10044568',
        pupilId: user.pupil_id.toString(),
      );
      emit(state.copyWith(
        albumData: albumData,
        statusAlbum: HomeStatus.success,
      ));
    }
  }

  _onGetPinnedAlbumIdList(
      HomeGetPinnedAlbumIdList event, Emitter<HomeState> emit) async {
    if (currentUserBloc.state.user.isKinderGarten()) {
      final user = currentUserBloc.state.user;
      final featuresLocal = await userRepository.getFeatures();

      final pinnedAlbumIdList = featuresLocal
          ?.firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LocalFeatures(
              user_key: '',
              features: [],
              pinnedAlbumIdList: [],
            ),
          )
          .pinnedAlbumIdList;
      emit(state.copyWith(pinnedAlbumIdList: pinnedAlbumIdList ?? []));
    }
  }

  _onUpdatePinnedAlbum(HomeUpdatePinnedAlbum event, Emitter<HomeState> emit) {
    if (!event.isOnlyUpdateState) {
      final user = currentUserBloc.state.user;
      userRepository.updatePinnedAlbum(event.pinnedAlbumIdList, user.user_key);
    }

    emit(state.copyWith(pinnedAlbumIdList: event.pinnedAlbumIdList));
  }

  _onRefresh(HomeRefresh event, Emitter<HomeState> emit) {
    final isKinderGarten = currentUserBloc.state.user.isKinderGarten();
    add(HomeFetchProfileData());
    add(HomeFetchNotificationData());

    if (isKinderGarten) {
      add(HomeFetchAlbumData());
      add(HomeGetPinnedAlbumIdList());
    } else {
      add(HomeFetchExercise());
    }
  }
}
