part of 'home_bloc.dart';

enum HomeStatus { init, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    required this.notificationData,
    required this.exerciseDueDateToday,
    required this.exerciseDueDateDataList,
    required this.exerciseInDayDataList,
    required this.albumData,
    required this.datePicked,
    this.statusNoti = HomeStatus.init,
    this.statusExercise = HomeStatus.init,
    this.statusAlbum = HomeStatus.init,
    this.profileStatus = HomeStatus.init,
    this.pinnedAlbumIdList = const [],
  });

  final NotificationData notificationData;
  final List<ExerciseItem> exerciseDueDateToday;
  final List<ExerciseItem> exerciseDueDateDataList;
  final List<ExerciseItem> exerciseInDayDataList;
  final AlbumData albumData;
  final List<int> pinnedAlbumIdList;

  final DateTime datePicked;
  final HomeStatus statusNoti;
  final HomeStatus statusExercise;
  final HomeStatus statusAlbum;
  final HomeStatus profileStatus;

  @override
  List<Object?> get props => [
        notificationData,
        exerciseDueDateToday,
        exerciseDueDateDataList,
        exerciseInDayDataList,
        datePicked,
        statusNoti,
        statusExercise,
        statusAlbum,
        albumData,
        pinnedAlbumIdList,
        profileStatus,
      ];

  HomeState copyWith({
    LessonData? lessonData,
    NotificationData? notificationData,
    List<ExerciseItem>? exerciseDueDateToday,
    List<ExerciseItem>? exerciseDueDateDataList,
    List<ExerciseItem>? exerciseInDayDataList,
    DateTime? datePicked,
    HomeStatus? statusNoti,
    HomeStatus? statusExercise,
    HomeStatus? statusAlbum,
    AlbumData? albumData,
    List<int>? pinnedAlbumIdList,
    HomeStatus? profileStatus,
  }) {
    return HomeState(
      exerciseDueDateDataList:
          exerciseDueDateDataList ?? this.exerciseDueDateDataList,
      exerciseDueDateToday: exerciseDueDateToday ?? this.exerciseDueDateToday,
      exerciseInDayDataList:
          exerciseInDayDataList ?? this.exerciseInDayDataList,
      albumData: albumData ?? this.albumData,
      notificationData: notificationData ?? this.notificationData,
      datePicked: datePicked ?? this.datePicked,
      statusNoti: statusNoti ?? this.statusNoti,
      statusExercise: statusExercise ?? this.statusExercise,
      statusAlbum: statusAlbum ?? this.statusAlbum,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
      profileStatus: profileStatus ?? this.profileStatus,
    );
  }
}
