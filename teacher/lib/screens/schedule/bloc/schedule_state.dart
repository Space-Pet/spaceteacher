part of 'schedule_bloc.dart';

enum ScheduleStatus { init, loading, success, failure }

enum ClassType {
  chuNhiem,
  giangDay,
}

extension ClassTypeExtension on ClassType {
  String get name {
    switch (this) {
      case ClassType.chuNhiem:
        return 'Lớp chủ nhiệm';
      case ClassType.giangDay:
        return 'Lớp giảng dạy';
      default:
        return 'Lớp giảng dạy';
    }
  }

  int get value {
    switch (this) {
      case ClassType.chuNhiem:
        return 1;
      case ClassType.giangDay:
        return 2;
      default:
        return 2;
    }
  }
}

class ScheduleState extends Equatable {
  const ScheduleState({
    required this.scheduleData,
    required this.datePicked,
    required this.exerciseDataList,
    this.status = ScheduleStatus.init,
    this.classType = ClassType.giangDay,
  });

  final Schedule scheduleData;
  final DateTime datePicked;
  final List<ExerciseItem> exerciseDataList;
  final ScheduleStatus status;
  final ClassType classType;

  @override
  List<Object?> get props => [
        scheduleData,
        datePicked,
        exerciseDataList,
        status,
        classType,
      ];

  ScheduleState copyWith({
    Schedule? scheduleData,
    DateTime? datePicked,
    List<ExerciseItem>? exerciseDataList,
    ScheduleStatus? status,
    ClassType? classType,
  }) {
    return ScheduleState(
      scheduleData: scheduleData ?? this.scheduleData,
      datePicked: datePicked ?? this.datePicked,
      exerciseDataList: exerciseDataList ?? this.exerciseDataList,
      status: status ?? this.status,
      classType: classType ?? this.classType,
    );
  }
}
