part of 'observation_detail_bloc.dart';

enum ObservationDetailStatus { initial, loading, success, failure }

class ObservationDetailState extends Equatable {
  const ObservationDetailState({
    this.status = ObservationDetailStatus.initial,
    this.observationData,
  });

  final ObservationDetailStatus status;
  final ObservationData? observationData;

  ObservationDetailState copyWith({
    ObservationDetailStatus? status,
    ObservationData? observationData,
  }) {
    return ObservationDetailState(
      status: status ?? this.status,
      observationData: observationData ?? this.observationData,
    );
  }

  @override
  List<Object?> get props => [status, observationData];
}
