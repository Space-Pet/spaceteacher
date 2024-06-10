part of 'observation_schedule_bloc.dart';

enum ObservationScheduleStatus {
  initial,
  loading,
  success,
  error,
}

class ObservationScheduleState extends Equatable {
  const ObservationScheduleState({
    this.status = ObservationScheduleStatus.initial,
    this.observationList = const <ObservationData>[],
    this.listTeacher = const <TeacherItem>[],
  });

  final ObservationScheduleStatus status;
  final List<ObservationData> observationList;
  final List<TeacherItem> listTeacher;

  ObservationScheduleState copyWith({
    ObservationScheduleStatus? status,
    List<ObservationData>? observationList,
    List<TeacherItem>? listTeacher,
  }) {
    return ObservationScheduleState(
      status: status ?? this.status,
      observationList: observationList ?? this.observationList,
      listTeacher: listTeacher ?? this.listTeacher,
    );
  }

  @override
  List<Object> get props => [
        status,
        observationList,
        listTeacher,
      ];
}
