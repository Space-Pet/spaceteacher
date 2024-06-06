part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeFetchExercise extends HomeEvent {
  HomeFetchExercise({this.isDueDate = true});

  final bool isDueDate;
}

class HomeExerciseSelectDate extends HomeEvent {
  HomeExerciseSelectDate({required this.datePicked});

  final DateTime datePicked;
}

class HomeFetchAlbumData extends HomeEvent {
  HomeFetchAlbumData();
}

class HomeFetchProfileData extends HomeEvent {
  HomeFetchProfileData();
}

class HomeFetchNotificationData extends HomeEvent {
  HomeFetchNotificationData();
}

class HomeRefresh extends HomeEvent {
  HomeRefresh();
}
