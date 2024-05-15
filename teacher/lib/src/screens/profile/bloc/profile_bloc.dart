import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import 'package:teacher/model/student_model.dart';
import 'package:teacher/repository/student_repository/student_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.studentRepository})
      : super(ProfileState(
            studentModel: StudentModel(), status: ProfileStatus.initial)) {
    on<ProfileGetProfilePupil>(_onProfileInitial);
  }
  final StudentRepository studentRepository;
  Future<void> _onProfileInitial(
      ProfileGetProfilePupil event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final studentInfo =
          await studentRepository.getInfoStudents(pupilId: event.pupilId);
      emit(state.copyWith(
          studentModel: studentInfo, status: ProfileStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ProfileBloc -> _onProfileInitial');
      emit(state.copyWith(
          status: ProfileStatus.error,
          errorString: 'ProfileBloc -> _onProfileInitial ${e.toString()}'));
      rethrow;
    }
  }
}
