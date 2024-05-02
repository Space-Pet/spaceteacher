// ignore_for_file: use_build_context_synchronously

import 'package:core/common/utils/snackbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  }) : super(ProfileState(
          pupil_id: '',
          user: userRepository.notSignedIn(),
          studentData: StudentData.empty(),
          parentData: ParentData.empty(),
        )) {
    on<GetProfileInfo>(_onGetProfileData);
    add(const GetProfileInfo());

    on<GetProfileStudent>(_onGetProfileStudent);
    on<GetProfileParent>(_onGetProfileParent);

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
        add(const GetProfileStudent());
        SnackBarUtils.showFloatingSnackBar(
            event.context, 'Cập nhật số điện thoại thành công');
      } else {
        emit(state.copyWith(
            profileStatus: ProfileStatus.fail, message: data['message']));
        SnackBarUtils.showFloatingSnackBar(event.context,
            'Cập nhật số điện thoại thất bại, vui lòng thử lại sau');
      }
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }

  void _onGetProfileData(
    GetProfileInfo event,
    Emitter<ProfileState> emit,
  ) {
    final isParent =
        currentUserBloc.state.user.type == ProfileType.parent.value;

    if (isParent) {
      add(const GetProfileParent());
    } else {
      add(const GetProfileStudent());
    }
  }

  void _onGetProfileStudent(
    GetProfileStudent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.init));
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

  void _onGetProfileParent(
    GetProfileParent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.init));
      final data = await userRepository.getProfileParent(
          pupilId: currentUserBloc.state.user.pupil_id.toString());
      emit(state.copyWith(
        profileStatus: ProfileStatus.success,
        parentData: data,
      ));

      add(const GetProfileStudent());
    } catch (e) {
      print('err: $e');
    }
  }
}
