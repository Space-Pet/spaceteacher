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

class HomeFetchProfileData extends HomeEvent {
  HomeFetchProfileData();
}

class HomeGetPinnedAlbumIdList extends HomeEvent {
  HomeGetPinnedAlbumIdList();
}

class HomeUpdatePinnedAlbum extends HomeEvent {
  HomeUpdatePinnedAlbum(this.pinnedAlbumIdList,
      {this.isOnlyUpdateState = false});

  final List<int> pinnedAlbumIdList;
  final bool isOnlyUpdateState;
}

class HomeFetchNotificationData extends HomeEvent {
  HomeFetchNotificationData();
}
