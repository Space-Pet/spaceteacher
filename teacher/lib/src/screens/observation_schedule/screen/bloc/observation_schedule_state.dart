part of 'observation_schedule_bloc.dart';

enum ObservationScheduleStatus { initial, loading, loaded, error }

class ObservationScheduleState extends Equatable {
  const ObservationScheduleState({
    this.status = ObservationScheduleStatus.initial,
    this.listHourlyAssessmentDetail = const [],
    this.errorString = '',
  });

  final ObservationScheduleStatus status;
  final List<HourlyAssessmentDetailModel> listHourlyAssessmentDetail;
  final String errorString;

  ObservationScheduleState copyWith({
    ObservationScheduleStatus? status,
    List<HourlyAssessmentDetailModel>? listHourlyAssessmentDetail,
    String? errorString,
  }) {
    return ObservationScheduleState(
      status: status ?? this.status,
      listHourlyAssessmentDetail:
          listHourlyAssessmentDetail ?? this.listHourlyAssessmentDetail,
      errorString: errorString ?? this.errorString,
    );
  }

  @override
  List<Object> get props => [status, listHourlyAssessmentDetail, errorString];
}
