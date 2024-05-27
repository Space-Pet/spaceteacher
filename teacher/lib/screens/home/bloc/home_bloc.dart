import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:teacher/screens/notifications/bloc/notification_bloc.dart';

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
          userData: TeacherDetail.empty(),
          albumData: AlbumData.empty,
          datePicked: DateTime.now(),
        )) {
    on<HomeFetchProfileData>(_onFetchTeacherDetail);
    add(HomeFetchProfileData());

    on<HomeFetchExercise>(_onFetchExercise);
    add(HomeFetchExercise());

    on<HomeFetchNotificationData>(_onFetchNotifications);
    add(HomeFetchNotificationData());

    on<HomeFetchAlbumData>(_onFetchAlbumData);
    add(HomeFetchAlbumData());

    on<HomeGetPinnedAlbumIdList>(_onGetPinnedAlbumIdList);
    add(HomeGetPinnedAlbumIdList());

    on<HomeUpdatePinnedAlbum>(_onUpdatePinnedAlbum);
    on<HomeExerciseSelectDate>(_onSelectDate);

    on<HomeRefresh>(_onRefresh);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onFetchTeacherDetail(
    HomeFetchProfileData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(profileStatus: HomeStatus.init));
    final teacherDetail = await userRepository
        .getTeacherDetail(currentUserBloc.state.user.teacher_id.toString());

    emit(state.copyWith(
      profileStatus: HomeStatus.success,
      userData: teacherDetail,
    ));
  }

  _onSelectDate(HomeExerciseSelectDate event, Emitter<HomeState> emit) async {
    emit(state.copyWith(statusExercise: HomeStatus.loading));

    final exerciseDueDateDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      datePicked: event.datePicked,
      // userKey: '0723210020',
    );

    emit(
      state.copyWith(
        exerciseDueDateDataList: exerciseDueDateDataList,
      ),
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
    if (!currentUserBloc.state.user.isKinderGarten) {
      emit(state.copyWith(statusExercise: HomeStatus.loading));

      final exerciseDataList = await appFetchApiRepo.getExercises(
        userKey: currentUserBloc.state.user.user_key,
        datePicked: DateTime.now(),
        isDueDate: event.isDueDate,
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
    if (currentUserBloc.state.user.isKinderGarten) {
      emit(state.copyWith(statusAlbum: HomeStatus.loading));

      final albumData = await appFetchApiRepo
          .getAlbum(currentUserBloc.state.user.teacher_id.toString());

      emit(state.copyWith(
        albumData: albumData,
        statusAlbum: HomeStatus.success,
      ));
    }
  }

  _onGetPinnedAlbumIdList(
      HomeGetPinnedAlbumIdList event, Emitter<HomeState> emit) async {
    if (currentUserBloc.state.user.isKinderGarten) {
      final user = currentUserBloc.state.user;
      final featuresLocal = await userRepository.getLoggedUsers() ?? [];

      final pinnedAlbumIdList = featuresLocal
          .firstWhere(
            (element) => element.user_key == user.user_key,
            orElse: () => LoggedUser.empty(),
          )
          .pinnedAlbumIdList;
      emit(state.copyWith(pinnedAlbumIdList: pinnedAlbumIdList));
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
    final isKinderGarten = currentUserBloc.state.user.isKinderGarten;
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
