import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/pupil_model.dart';
import 'package:teacher/model/student_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/repository/student_repository/student_repository.dart';
import 'package:teacher/repository/user_repository/user_repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.studentRepository})
      : super(ProfileState(studentModel: StudentModel())) {
    on<ProfileGetProfilePupil>(_onProfileInitial);
  }
  final StudentRepository studentRepository;
  Future<void> _onProfileInitial(
      ProfileGetProfilePupil event, Emitter<ProfileState> emit) async {
    try {
      final studentInfo =
          await studentRepository.getInfoStudents(pupilId: event.pupilId);
      emit(state.copyWith(studentModel: studentInfo));
    } catch (e) {
      Log.e('$e', name: 'ProfileBloc -> _onProfileInitial');
      rethrow;
    }
  }
}
