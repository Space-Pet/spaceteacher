// ignore_for_file: non_constant_identifier_names

part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.user,
    this.profileStatus = ProfileStatus.init,
  });
  final TeacherDetail user;
  final ProfileStatus profileStatus;

  @override
  List<Object?> get props => [user, profileStatus];

  ProfileState copyWith({
    TeacherDetail? user,
    ProfileStatus? profileStatus,
  }) {
    return ProfileState(
      user: user ?? this.user,
      profileStatus: profileStatus ?? this.profileStatus,
    );
  }
}

enum ProfileStatus { init, success, error, fail, initUpdate, successUpdate }
