// ignore_for_file: non_constant_identifier_names

part of 'profile_bloc.dart';

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

class ProfileState extends Equatable {
  const ProfileState({
    required this.studentData,
    required this.parentData,
    required this.user,
    required this.pupil_id,
    this.message,
    this.profileStatus = ProfileStatus.init,
  });
  final StudentData studentData;
  final ParentData parentData;
  final ProfileStatus profileStatus;
  final String pupil_id;
  final ProfileInfo user;
  final String? message;
  @override
  List<Object?> get props =>
      [studentData, profileStatus, user, pupil_id, message];

  static final statusMap = {
    0: 'Đang học',
    2: 'Đã nghỉ',
    7: 'Đã tốt nghiệp',
    8: 'Bảo lưu',
  };

  ProfileState copyWith({
    StudentData? studentData,
    ParentData? parentData,
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
        parentData: parentData ?? this.parentData,
        pupil_id: pupil_id ?? this.pupil_id);
  }
}
