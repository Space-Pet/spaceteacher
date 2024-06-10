part of 'schedule_bloc.dart';

sealed class ScheduleEvent {}

class ScheduleFetchData extends ScheduleEvent {
  ScheduleFetchData();
}

class ScheduleFilterChanged extends ScheduleEvent {
  ScheduleFilterChanged({required this.filter});
  final ScheduleFilter filter;
}

class ScheduleFetchExercise extends ScheduleEvent {
  ScheduleFetchExercise({required this.datePicked});

  final DateTime datePicked;
}

class ScheduleSelectDate extends ScheduleEvent {
  ScheduleSelectDate({required this.datePicked});

  final DateTime datePicked;
}
