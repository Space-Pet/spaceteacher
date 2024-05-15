part of 'observation_schedule_bloc.dart';

enum ObservationScheduleStatus { initial, loading, loaded, error }

class ObservationScheduleState extends Equatable {
  const ObservationScheduleState({
    this.status = ObservationScheduleStatus.initial,
    this.observationSchedule = const [],
    this.errorString = '',
  });

  final ObservationScheduleStatus status;
  final List<dynamic> observationSchedule;
  final String errorString;

  ObservationScheduleState copyWith({
    ObservationScheduleStatus? status,
    List<dynamic>? observationSchedule,
    String? errorString,
  }) {
    return ObservationScheduleState(
      status: status ?? this.status,
      observationSchedule: observationSchedule ?? this.observationSchedule,
      errorString: errorString ?? this.errorString,
    );
  }

  @override
  List<Object> get props => [status, observationSchedule, errorString];
}
