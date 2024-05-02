part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetProfileInfo extends ProfileEvent {
  const GetProfileInfo();
}

class GetProfileStudent extends ProfileEvent {
  const GetProfileStudent();
}

class GetProfileParent extends ProfileEvent {
  const GetProfileParent();
}

class CurrentUserUpdated extends ProfileEvent {
  const CurrentUserUpdated({required this.user});
  final ProfileInfo user;
}

class UpdateProfileStudent extends ProfileEvent {
  const UpdateProfileStudent({
    required this.phone,
    required this.motherName,
    required this.fatherPhone,
    required this.context,
  });
  final String phone;
  final String motherName;
  final String fatherPhone;
  final BuildContext context;
}
