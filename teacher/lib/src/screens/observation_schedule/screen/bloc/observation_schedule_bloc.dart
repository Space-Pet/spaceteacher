import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/repository/observation_repository/observation_repositories.dart';

part 'observatiom_schedule_event.dart';
part 'observation_schedule_state.dart';

class ObservationScheduleBloc
    extends Bloc<ObservationScheduleEvent, ObservationScheduleState> {
  ObservationScheduleBloc({required this.observationRepository})
      : super(
          const ObservationScheduleState(
              status: ObservationScheduleStatus.initial),
        ) {
    on<GetObservationSchedule>(_onGetObservationSchedule);
  }

  final ObservationRepository observationRepository;
  Future<List<dynamic>> _onGetObservationSchedule(GetObservationSchedule event,
      Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      final observationSchedule =
          await observationRepository.getObservationSchedule();
      emit(state.copyWith(
          observationSchedule: observationSchedule,
          status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ObservationScheduleBloc -> _onGetObservationSchedule');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onGetObservationSchedule ${e.toString()}'));
      rethrow;
    }
    return [];
  }
}
