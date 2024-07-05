import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(ScheduleState(
          scheduleData: Schedule.empty(),
          exerciseDataList: const [],
          datePicked: DateTime.now(),
        )) {
    on<ScheduleFetchData>(_onFetchScheduleData);
    on<ScheduleSelectDate>(_onSelectDate);
    on<ScheduleFetchExercise>(_onFetchDueDateExercises);
    on<ScheduleChangeClassType>(_onScheduleFilterChange);

    add(ScheduleFetchData());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchDueDateExercises(
      ScheduleFetchExercise event, Emitter<ScheduleState> emit) async {
    final exerciseDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      datePicked: event.datePicked,
    );

    emit(
      state.copyWith(
        exerciseDataList: exerciseDataList,
      ),
    );
  }

  _onFetchScheduleData(
      ScheduleFetchData event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(
      scheduleData: Schedule.empty(),
      status: ScheduleStatus.loading,
    ));

    final scheduleData = await appFetchApiRepo.getSchedule(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: state.datePicked.ddMMyyyyDash,
      classType: state.classType.value,
    );
    emit(
      state.copyWith(
        scheduleData: scheduleData,
        status: ScheduleStatus.success,
      ),
    );
  }

  _onSelectDate(ScheduleSelectDate event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(datePicked: event.datePicked));
    add(ScheduleFetchData());
  }

  void _onScheduleFilterChange(
      ScheduleChangeClassType event, Emitter<ScheduleState> emit) {
    final newClassType = event.classTypeName == ClassType.chuNhiem.name
        ? ClassType.chuNhiem
        : ClassType.giangDay;

    emit(state.copyWith(classType: newClassType));
    add(ScheduleFetchData());
  }
}
