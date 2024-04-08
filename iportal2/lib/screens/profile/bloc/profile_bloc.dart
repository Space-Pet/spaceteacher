import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.userRepository,
    required this.currentUserBloc,
  }) : super(ProfileState(user: userRepository.notSignedIn(), pupil_id: '')) {
    on<GetProfileUser>(_onGetProfileUser);
    on<CurrentUserUpdated>(_onUpdateUser);
    on<UpdateProfileStudent>(_onUpdateProfileStudent);
  }
  final UserRepository userRepository;
  final CurrentUserBloc currentUserBloc;

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      user: event.user,
    ));
  }

  void _onUpdateProfileStudent(
      UpdateProfileStudent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.initUpdate));
      final data = await userRepository.updateProfileStudent(
          phone: event.phone,
          motherName: event.motherName,
          fatherPhone: event.fatherPhone,
          pupil_id: currentUserBloc.state.user.pupil_id.toString());

      if (data!['code'] == 200) {
        emit(state.copyWith(profileStatus: ProfileStatus.successUpdate));
      } else if (data['code'] != 200 && data['code'] != 0) {
        emit(state.copyWith(
            profileStatus: ProfileStatus.fail, message: data['message']));
      }
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }

  void _onGetProfileUser(
    GetProfileUser event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(
          state.copyWith(profileStatus: ProfileStatus.init, studentData: null));
      final data = await userRepository.getProfileStudent(
          pupil_id: currentUserBloc.state.user.pupil_id.toString());
      emit(state.copyWith(
        profileStatus: ProfileStatus.success,
        studentData: data,
      ));
    } catch (e) {
      print('err: $e');
    }
  }
}
