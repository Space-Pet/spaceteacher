part of 'home_bloc.dart';

enum HomeStatus { init, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    required this.notificationData,
    required this.exerciseDueDateToday,
    required this.exerciseDueDateDataList,
    required this.exerciseInDayDataList,
    required this.datePicked,
    this.statusNoti = HomeStatus.init,
    this.statusExercise = HomeStatus.init,
  });

  final NotificationData notificationData;
  final ExerciseData exerciseDueDateToday;
  final ExerciseData exerciseDueDateDataList;
  final ExerciseData exerciseInDayDataList;

  final DateTime datePicked;
  final HomeStatus statusNoti;
  final HomeStatus statusExercise;

  @override
  List<Object?> get props => [
        notificationData,
        exerciseDueDateToday,
        exerciseDueDateDataList,
        exerciseInDayDataList,
        datePicked,
        statusNoti,
        statusExercise,
      ];

  HomeState copyWith({
    LessonData? lessonData,
    NotificationData? notificationData,
    ExerciseData? exerciseDueDateToday,
    ExerciseData? exerciseDueDateDataList,
    ExerciseData? exerciseInDayDataList,
    DateTime? datePicked,
    HomeStatus? statusNoti,
    HomeStatus? statusExercise,
  }) {
    return HomeState(
      exerciseDueDateDataList:
          exerciseDueDateDataList ?? this.exerciseDueDateDataList,
      exerciseDueDateToday: exerciseDueDateToday ?? this.exerciseDueDateToday,
      exerciseInDayDataList:
          exerciseInDayDataList ?? this.exerciseInDayDataList,
      notificationData: notificationData ?? this.notificationData,
      datePicked: datePicked ?? this.datePicked,
      statusNoti: statusNoti ?? this.statusNoti,
      statusExercise: statusExercise ?? this.statusExercise,
    );
  }
}
