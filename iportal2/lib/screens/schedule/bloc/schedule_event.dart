part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleEvent {}

class ScheduleFetchData extends ScheduleEvent {
  ScheduleFetchData();
}

class ScheduleFetchExercise extends ScheduleEvent {
  ScheduleFetchExercise();
}

class ScheduleSelectDate extends ScheduleEvent {
  ScheduleSelectDate({required this.datePicked});

  final DateTime datePicked;
}
