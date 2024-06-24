import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

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
    on<ScheduleFilterChanged>(_onScheduleFilterChange);

    add(ScheduleFetchData());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchDueDateExercises(
      ScheduleFetchExercise event, Emitter<ScheduleState> emit) async {
    final exerciseDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      datePicked: event.datePicked,
      // userKey: '0723210020',
    );

    emit(
      state.copyWith(
        exerciseDataList: exerciseDataList,
      ),
    );
  }

  _onSelectDate(ScheduleSelectDate event, Emitter<ScheduleState> emit) async {
    final scheduleData = await appFetchApiRepo.getSchedule(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: event.datePicked.ddMMyyyyDash,
      // userKey: '0563230098',
    );
    emit(
      state.copyWith(
        scheduleData: scheduleData,
        datePicked: event.datePicked,
      ),
    );
  }

  _onFetchScheduleData(
      ScheduleFetchData event, Emitter<ScheduleState> emit) async {
    emit(state.copyWith(status: ScheduleStatus.loading));

    final scheduleData = await appFetchApiRepo.getSchedule(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateTime.now().ddMMyyyyDash,
      // txtDate: '18-03-2024',
      // userKey: '0563230098',
    );
    emit(
      state.copyWith(
        scheduleData: scheduleData,
        status: ScheduleStatus.success,
      ),
    );
  }

  void _onScheduleFilterChange(
    ScheduleFilterChanged event,
    Emitter<ScheduleState> emit,
  ) {
    emit(
      state.copyWith(filter: event.filter),
    );

    //TODO: Fetch list when filter changed
  }
}
