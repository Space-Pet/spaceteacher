part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileGetProfilePupil extends ProfileEvent {
  final int? pupilId;
  const ProfileGetProfilePupil({this.pupilId});
}
