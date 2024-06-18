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
          exerciseDueDateToday: ExerciseItem.fakeData(),
          exerciseDueDateDataList: const [],
          exerciseInDayDataList: const [],
          notificationData: NotificationData.fakeData(),
          albumData: AlbumData.fakeData,
          datePicked: DateTime.now(),
        )) {
    on<HomeFetchExercise>(_onFetchExercise);
    add(HomeFetchExercise());
    on<HomeExerciseSelectDate>(_onSelectDate);

    on<HomeFetchNotificationData>(_onFetchNotifications);
    add(HomeFetchNotificationData());

    on<HomeFetchAlbumData>(_onFetchAlbumData);
    add(HomeFetchAlbumData());

    on<HomeRefresh>(_onRefresh);

    on<HomeFetchLearnYearList>(_onFetchLearnYearList);
    add(HomeFetchLearnYearList());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  _onSelectDate(HomeExerciseSelectDate event, Emitter<HomeState> emit) async {
    emit(state.copyWith(statusExercise: HomeStatus.loading));

    final exerciseDueDateDataList = await appFetchApiRepo.getExercises(
      // userKey: currentUserBloc.state.activeChild.user_key,
      datePicked: event.datePicked,
      userKey: '0253230044',
    );

    emit(
      state.copyWith(exerciseDueDateDataList: exerciseDueDateDataList),
    );

    final exerciseInDayDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.activeChild.user_key,
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
    if (!currentUserBloc.state.activeChild.isMN) {
      emit(state.copyWith(statusExercise: HomeStatus.loading));

      // create DateTime for 29/05/2024
      final dateTimeTest = DateTime(2024, 9, 25);
      final exerciseDataList = await appFetchApiRepo.getExercises(
        // userKey: currentUserBloc.state.activeChild.user_key,
        datePicked: dateTimeTest,
        isDueDate: event.isDueDate,
        // txtDate: '18-03-2024',
        userKey: '0253230044',
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

    final user = currentUserBloc.state.activeChild;
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
      notificationData: notificationData,
      statusNoti: HomeStatus.success,
    ));
  }

  _onFetchAlbumData(HomeFetchAlbumData event, Emitter<HomeState> emit) async {
    if (currentUserBloc.state.activeChild.isMN) {
      emit(state.copyWith(statusAlbum: HomeStatus.loading));

      final user = currentUserBloc.state.activeChild;
      final albumData = await appFetchApiRepo.getAlbum(
        pupilId: user.pupil_id.toString(),
      );

      emit(state.copyWith(
        albumData: albumData,
        statusAlbum: HomeStatus.success,
      ));
    }
  }

  _onRefresh(HomeRefresh event, Emitter<HomeState> emit) {
    final isKinderGarten = currentUserBloc.state.activeChild.isMN;
    add(HomeFetchNotificationData());

    if (isKinderGarten) {
      add(HomeFetchAlbumData());
    } else {
      add(HomeFetchExercise());
    }
  }

  _onFetchLearnYearList(
      HomeFetchLearnYearList event, Emitter<HomeState> emit) async {
    final activeChild = currentUserBloc.state.activeChild;

    final learnYear = await appFetchApiRepo.getLearnYearList(
      schoolId: activeChild.school_id,
    );

    currentUserBloc.add(CurrentUserChangeActiveChild(
      activeChild.copyWith(learnYearList: learnYear),
    ));

    emit(state.copyWith(statusHome: HomeStatus.success));
  }
}
