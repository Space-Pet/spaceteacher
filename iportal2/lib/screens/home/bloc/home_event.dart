part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeFetchExercise extends HomeEvent {
  HomeFetchExercise({this.isDueDate = true});

  final bool isDueDate;
}

class HomeExerciseSelectDate extends HomeEvent {
  HomeExerciseSelectDate({required this.datePicked});

  final DateTime datePicked;
}

class HomeFetchNotificationData extends HomeEvent {
  HomeFetchNotificationData();
}
