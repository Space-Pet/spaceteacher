part of 'observation_schedule_bloc.dart';

abstract class ObservationScheduleEvent extends Equatable {
  const ObservationScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetObservationSchedule extends ObservationScheduleEvent {
  const GetObservationSchedule();
}

class GetObservationScheduleDetail extends ObservationScheduleEvent {
  const GetObservationScheduleDetail({required this.id});
  final String id;
}
