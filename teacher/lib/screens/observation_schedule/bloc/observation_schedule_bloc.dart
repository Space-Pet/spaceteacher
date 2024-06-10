import 'dart:developer';

import 'package:core/core.dart';
import 'package:core/data/models/observation_model.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';

part 'observation_schedule_event.dart';
part 'observation_schedule_state.dart';

class ObservationScheduleBloc
    extends Bloc<ObservationScheduleEvent, ObservationScheduleState> {
  ObservationScheduleBloc({
    required this.appFetchApiRepo,
    required this.userKey,
    required this.schoolId,
  }) : super(const ObservationScheduleState()) {
    on<ObservationScheduleInit>(_onInit);
    on<ObservationScheduleFetched>(_onObservationScheduleFetch);
    on<ListTeacherFetched>(_onListTeacherFetch);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final String userKey;
  final int schoolId;

  void _onInit(
    ObservationScheduleInit event,
    Emitter<ObservationScheduleState> emit,
  ) {
    add(ObservationScheduleFetched(
      txtDate: DateFormat("dd-MM-yyyy", 'vi_VN').format(
        DateTime.now(),
      ),
    ));
  }

  Future<void> _onObservationScheduleFetch(
    ObservationScheduleFetched event,
    Emitter<ObservationScheduleState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));

      final response = await appFetchApiRepo.getLessonRegister(
        userKey: userKey,
        txtDate: event.txtDate,
        schoolId: schoolId,
      );

      log('ObservationScheduleBloc - Exception - ${response.toString()}');

      emit(
        state.copyWith(
          status: ObservationScheduleStatus.success,
          observationList: response,
        ),
      );
    } catch (e) {
      log('ObservationScheduleBloc - Exception - $e');
      emit(state.copyWith(status: ObservationScheduleStatus.error));
    }
  }

  Future<void> _onListTeacherFetch(
    ListTeacherFetched event,
    Emitter<ObservationScheduleState> emit,
  ) async {
    try {
      final listTeacher =
          await appFetchApiRepo.getTeacherListBySchool(schoolId: schoolId);
      emit(state.copyWith(listTeacher: listTeacher));
    } catch (e) {
      log('ObservationScheduleBloc - Exception - $e');
      emit(
        state.copyWith(
          listTeacher: [],
        ),
      );
    }
  }
}
