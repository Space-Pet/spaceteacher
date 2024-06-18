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

class HomeFetchAlbumData extends HomeEvent {
  HomeFetchAlbumData();
}

class UpdateProfile extends HomeEvent {
  UpdateProfile({
    required this.phone,
    required this.motherName,
    required this.fatherPhone,
  });
  final String phone;
  final String motherName;
  final String fatherPhone;
}

class HomeFetchNotificationData extends HomeEvent {
  HomeFetchNotificationData();
}

class HomeRefresh extends HomeEvent {
  HomeRefresh();
}

class HomeFetchLearnYearList extends HomeEvent {
  HomeFetchLearnYearList();
}
