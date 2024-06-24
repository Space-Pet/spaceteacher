import 'package:core/core.dart';
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
    on<UpdatePhone>(_updatePhone);
    on<CancelUpdatePhone>(_cancelUpdatePhone);
    on<UpdateStudentPhone>(_onUpdateStudentPhone);
    on<UpdateParentPhone>(_onUpdateParentPhone);
  }

  final UserRepository userRepository;
  final CurrentUserBloc currentUserBloc;

  void _onGetProfileData(
    GetProfileInfo event,
    Emitter<ProfileState> emit,
  ) {
    final isStudent = currentUserBloc.state.user.isStudent();

    if (!isStudent) {
      add(const GetProfileParent());
    }
    add(const GetProfileStudent());
  }

  void _onGetProfileParent(
    GetProfileParent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.init));
      final data = await userRepository.getProfileParent(
          pupilId: currentUserBloc.state.activeChild.pupil_id.toString());
      emit(state.copyWith(parentData: data));
    } catch (e) {
      print('err: $e');
    }
  }

  void _onGetProfileStudent(
    GetProfileStudent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.init));
      final data = await userRepository.getProfileStudent(
          pupilId: currentUserBloc.state.activeChild.pupil_id.toString());

      emit(state.copyWith(
        studentData: data,
        profileStatus: ProfileStatus.success,
      ));
    } catch (e) {
      print('err: $e');
    }
  }

  Future<dynamic> _onUpdateUser(
    CurrentUserUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      user: event.user,
    ));
  }

  void _onUpdateStudentPhone(
      UpdateStudentPhone event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.initUpdate));
      final data = await userRepository.updateStudentPhone(
          phone: event.phone,
          motherName: event.motherName,
          fatherPhone: event.fatherPhone,
          pupilId: currentUserBloc.state.activeChild.pupil_id.toString());

      if (data!['code'] == 200) {
        add(const GetProfileStudent());
        emit(state.copyWith(
          profileStatus: ProfileStatus.successUpdate,
          phoneUpdate: '',
          errMessage: '',
        ));
      } else {
        emit(state.copyWith(
            profileStatus: ProfileStatus.fail, errMessage: data['message']));
      }
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }

  void _onUpdateParentPhone(
      UpdateParentPhone event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(profileStatus: ProfileStatus.initUpdate));
      final parent = state.parentData.parents;

      final body = {
        "father_mobile_phone":
            event.isFather ? event.phone : parent.fatherPhone,
        "mother_mobile_phone":
            event.isFather ? parent.motherPhone : event.phone,
        "mother_name": parent.motherName,
        "parent_id": parent.parentId,
        "father_year": parent.fatherYear,
        "father_job": parent.fatherJob,
        "father_address": parent.fatherAddress,
        "father_work_address": parent.fatherAddress,
        "father_email": parent.fatherEmail,
        "mother_year": parent.motherYear,
        "mother_job": parent.motherJob,
        "mother_address": parent.motherAddress,
        "mother_work_address": parent.motherWorkAddress,
        "mother_email": parent.motherEmail,
      };

      final data = await userRepository.updateParentPhone(
          body, currentUserBloc.state.activeChild.pupil_id.toString());

      if (data!['code'] == 200) {
        add(const GetProfileParent());
        emit(state.copyWith(
          profileStatus: ProfileStatus.successUpdate,
          phoneUpdate: '',
          errMessage: '',
        ));
      } else {
        emit(state.copyWith(
            profileStatus: ProfileStatus.fail, errMessage: data['message']));
      }
    } catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error));
    }
  }

  void _updatePhone(
    UpdatePhone event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(phoneUpdate: event.newPhoneNum));

    if (event.newPhoneNum.length > 10) {
      emit(state.copyWith(errMessage: 'Số điện thoại không hợp lệ'));
    } else {
      emit(state.copyWith(errMessage: ''));
    }
  }

  void _cancelUpdatePhone(
    CancelUpdatePhone event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(phoneUpdate: '', errMessage: ''));
  }
}
