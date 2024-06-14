part of 'observation_schedule_bloc.dart';

enum ObservationScheduleStatus {
  initial,
  loading,
  success,
  error,
}

extension ObservationScheduleStatusX on ObservationScheduleStatus {
  bool get isInitial => this == ObservationScheduleStatus.initial;
  bool get isLoading => this == ObservationScheduleStatus.loading;
  bool get isSuccess => this == ObservationScheduleStatus.success;
  bool get isError => this == ObservationScheduleStatus.error;
}

class ObservationScheduleState extends Equatable {
  const ObservationScheduleState({
    this.status = ObservationScheduleStatus.initial,
    this.observationList = const [],
  });

  final ObservationScheduleStatus status;
  final List<ObservationData> observationList;

  ObservationScheduleState copyWith({
    ObservationScheduleStatus? status,
    List<ObservationData>? observationList,
  }) {
    return ObservationScheduleState(
      status: status ?? this.status,
      observationList: observationList ?? this.observationList,
    );
  }

  @override
  List<Object> get props => [
        status,
        observationList,
      ];
}
