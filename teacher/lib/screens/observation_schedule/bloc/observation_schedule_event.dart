part of 'observation_schedule_bloc.dart';

abstract class ObservationScheduleEvent {}

class ObservationScheduleInit extends ObservationScheduleEvent {}

class ObservationScheduleFetched extends ObservationScheduleEvent {
  ObservationScheduleFetched({
    required this.txtDate,
    this.teacherId,
  });

  final String txtDate;
  final String? teacherId;
}
