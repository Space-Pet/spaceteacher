part of 'profile_bloc.dart';

enum ProfileStatus { init, success, error, fail, initUpdate, successUpdate }

class ProfileState extends Equatable {
  const ProfileState(
      {this.studentData,
      required this.user,
      required this.pupil_id,
      this.message,
      this.profileStatus = ProfileStatus.init});
  final StudentData? studentData;
  final ProfileStatus profileStatus;
  final String pupil_id;
  final ProfileInfo user;
  final String? message;
  @override
  List<Object?> get props => [studentData, profileStatus, user, pupil_id, message];

  ProfileState copyWith({
    StudentData? studentData,
    ProfileStatus? profileStatus,
    ProfileInfo? user,
    String? message,
    String? pupil_id,
  }) {
    return ProfileState(
      message: message ?? this.message,
        user: user ?? this.user,
        profileStatus: profileStatus ?? this.profileStatus,
        studentData: studentData ?? this.studentData,
        pupil_id: pupil_id ?? this.pupil_id);
  }
}
