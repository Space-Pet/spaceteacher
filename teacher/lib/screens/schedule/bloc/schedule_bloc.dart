import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:meta/meta.dart';
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

    add(ScheduleFetchData());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchDueDateExercises(
      ScheduleFetchExercise event, Emitter<ScheduleState> emit) async {
    final exerciseDataList = await appFetchApiRepo.getExercises(
      // userKey: currentUserBloc.state.user.user_key,
      datePicked: event.datePicked,
      userKey: '0723210020',
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
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
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
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
}
