part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetProfileUser extends ProfileEvent {
  const GetProfileUser();
  @override
  List<Object> get props => [];
}

class CurrentUserUpdated extends ProfileEvent {
  CurrentUserUpdated({required this.user});
  final ProfileInfo user;
}
class UpdateProfileStudent extends ProfileEvent {
  const UpdateProfileStudent({
      required this.phone,
      required this.motherName,
      required this.fatherPhone,

  });
  final String phone;
  final String motherName;
  final String fatherPhone;

}
