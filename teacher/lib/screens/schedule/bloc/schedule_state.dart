part of 'schedule_bloc.dart';

enum ScheduleStatus { init, loading, success, failure }

enum ScheduleFilter {
  lopChuNhiem,
  lopGiangDay,
}

extension ScheduleFilterExtension on ScheduleFilter {
  String get name {
    switch (this) {
      case ScheduleFilter.lopChuNhiem:
        return 'Lớp chủ nhiệm';
      case ScheduleFilter.lopGiangDay:
        return 'Lớp giảng dạy';
      default:
        return '';
    }
  }
}

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.scheduleData,
    required this.datePicked,
    required this.exerciseDataList,
    this.status = ScheduleStatus.init,
    this.filter = ScheduleFilter.lopChuNhiem,
  });

  final Schedule scheduleData;
  final DateTime datePicked;
  final List<ExerciseItem> exerciseDataList;
  final ScheduleStatus status;
  final ScheduleFilter filter;

  @override
  List<Object?> get props => [
        scheduleData,
        datePicked,
        exerciseDataList,
        status,
        filter,
      ];

  ScheduleState copyWith({
    Schedule? scheduleData,
    DateTime? datePicked,
    List<ExerciseItem>? exerciseDataList,
    ScheduleStatus? status,
    ScheduleFilter? filter,
  }) {
    return ScheduleState(
      scheduleData: scheduleData ?? this.scheduleData,
      datePicked: datePicked ?? this.datePicked,
      exerciseDataList: exerciseDataList ?? this.exerciseDataList,
      status: status ?? this.status,
      filter: filter ?? this.filter,
    );
  }
}
