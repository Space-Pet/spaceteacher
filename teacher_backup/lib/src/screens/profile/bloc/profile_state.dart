part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  final StudentModel studentModel;
  final ProfileStatus status;
  final String? errorString;
  const ProfileState(
      {required this.studentModel, required this.status, this.errorString});

  ProfileState copyWith({
    StudentModel? studentModel,
    ProfileStatus? status,
    String? errorString,
  }) {
    return ProfileState(
      studentModel: studentModel ?? this.studentModel,
      status: status ?? this.status,
      errorString: errorString ?? this.errorString,
    );
  }

  @override
  List<Object?> get props => [studentModel, status, errorString];
}
