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

class UpdatePhone extends ProfileEvent {
  const UpdatePhone({required this.newPhoneNum});
  final String newPhoneNum;
}

class CancelUpdatePhone extends ProfileEvent {
  const CancelUpdatePhone();
}

class UpdateStudentPhone extends ProfileEvent {
  const UpdateStudentPhone({
    required this.phone,
    required this.motherName,
    required this.fatherPhone,
  });
  final String phone;
  final String motherName;
  final String fatherPhone;
}

class UpdateParentPhone extends ProfileEvent {
  const UpdateParentPhone({
    required this.phone,
    this.isFather = true,
  });
  final String phone;
  final bool isFather;
}
