part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final StudentModel studentModel;

  const ProfileState({required this.studentModel});

  ProfileState copyWith({
    StudentModel? studentModel,
  }) {
    return ProfileState(
      studentModel: studentModel ?? this.studentModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
