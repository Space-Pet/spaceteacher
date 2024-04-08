import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(HomeState(
          exerciseDueDateToday: ExerciseData.empty(),
          exerciseDueDateDataList: ExerciseData.empty(),
          exerciseInDayDataList: ExerciseData.empty(),
          notificationData: NotificationData.empty(),
          datePicked: DateTime.now(),
        )) {
    on<HomeFetchExercise>(_onFetchExercise);
    add(HomeFetchExercise());

    on<HomeFetchNotificationData>(_onFetchNotifications);
    add(HomeFetchNotificationData());

    on<HomeExerciseSelectDate>(_onSelectDate);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onSelectDate(HomeExerciseSelectDate event, Emitter<HomeState> emit) async {
    emit(state.copyWith(statusExercise: HomeStatus.loading));

    final exerciseDueDateDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
      // userKey: '0563230098',
    );
    emit(
      state.copyWith(
        exerciseDueDateDataList: exerciseDueDateDataList,
      ),
    );

    final exerciseInDayDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
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
    emit(state.copyWith(statusExercise: HomeStatus.loading));

    final exerciseDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      isDueDate: event.isDueDate,
      // txtDate: '18-03-2024',
      // userKey: '0563230098',
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

  _onFetchNotifications(
      HomeFetchNotificationData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(statusNoti: HomeStatus.loading));

    final user = currentUserBloc.state.user;
    final headers = {
      'School-Id': user.school_id,
      'School-Brand': user.school_name,
    };

    final notificationData = await appFetchApiRepo.getNotifications(
      headers: headers,
    );
    emit(state.copyWith(
        notificationData: notificationData, statusNoti: HomeStatus.success));
  }
}
