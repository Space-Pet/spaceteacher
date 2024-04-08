part of 'week_schedule_bloc.dart';

enum WeekScheduleStatus { init, success, error }

class WeekScheduleState extends Equatable {
  const WeekScheduleState(
      {this.weekSchedule,
      this.weekScheduleStatus = WeekScheduleStatus.init,
      required this.user});
  final WeekSchedule? weekSchedule;
  final WeekScheduleStatus weekScheduleStatus;
  final ProfileInfo user;

  @override
  List<Object?> get props => [weekSchedule, weekScheduleStatus];

  WeekScheduleState copyWith({
    WeekSchedule? weekSchedule,
    WeekScheduleStatus? weekScheduleStatus,
    ProfileInfo? user,
  }) {
    return WeekScheduleState(
        user: user ?? this.user,
        weekSchedule: weekSchedule ?? this.weekSchedule,
        weekScheduleStatus: weekScheduleStatus ?? this.weekScheduleStatus);
  }
}
