// ignore_for_file: non_constant_identifier_names

part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.studentData,
    required this.parentData,
    required this.user,
    required this.pupil_id,
    this.phoneUpdate = '',
    this.errMessage = '',
    this.profileStatus = ProfileStatus.init,
  });
  final StudentData studentData;
  final ParentData parentData;
  final ProfileStatus profileStatus;
  final String pupil_id;
  final ProfileInfo user;

  final String phoneUpdate;
  final String errMessage;

  @override
  List<Object?> get props => [
        studentData,
        parentData,
        profileStatus,
        user,
        pupil_id,
        errMessage,
        phoneUpdate
      ];

  ProfileState copyWith({
    StudentData? studentData,
    ParentData? parentData,
    ProfileStatus? profileStatus,
    ProfileInfo? user,
    String? pupil_id,
    String? phoneUpdate,
    String? errMessage,
  }) {
    return ProfileState(
      errMessage: errMessage ?? this.errMessage,
      user: user ?? this.user,
      profileStatus: profileStatus ?? this.profileStatus,
      studentData: studentData ?? this.studentData,
      parentData: parentData ?? this.parentData,
      pupil_id: pupil_id ?? this.pupil_id,
      phoneUpdate: phoneUpdate ?? this.phoneUpdate,
    );
  }
}

enum ProfileStatus { init, success, error, fail, initUpdate, successUpdate }

enum ProfileType { student, parent }

extension ProfileTypeExtension on ProfileType {
  int get value {
    switch (this) {
      case ProfileType.student:
        return 0;
      case ProfileType.parent:
        return 2;
    }
  }
}
