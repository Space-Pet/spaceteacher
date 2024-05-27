import 'package:core/data/models/teacher_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.userRepository,
    required this.currentUserBloc,
  }) : super(ProfileState(user: TeacherDetail.empty())) {
    on<GetTeacherInfo>(_onGetProfileData);
    add(const GetTeacherInfo());
  }

  final UserRepository userRepository;
  final CurrentUserBloc currentUserBloc;

  void _onGetProfileData(
    GetTeacherInfo event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.init));
    } catch (e) {
      print('err: $e');
    }
  }
}
