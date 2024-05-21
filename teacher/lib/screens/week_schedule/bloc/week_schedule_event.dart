part of 'week_schedule_bloc.dart';

abstract class WeekScheduleEvent extends Equatable {
  const WeekScheduleEvent();
  @override
  List<Object?> get props => [];
}

class GetWeekSchedule extends WeekScheduleEvent {
  const GetWeekSchedule({required this.txtDate, required this.date});
  final String txtDate;
  final DateTime date;
}