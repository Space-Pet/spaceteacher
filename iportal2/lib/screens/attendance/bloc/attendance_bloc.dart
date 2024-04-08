import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;
  AttendanceBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.userRepository})
      : super(AttendanceState(user: userRepository.notSignedIn())) {
    on<GetAttendanceDay>(_onGetAttendanceDay);
    on<GetAttendanceWeek>(_onGetAttendanceWeek);
    on<GetAttendanceMonth>(_onGetAttendanceMonth);
  }
  void _onGetAttendanceDay(
      GetAttendanceDay event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.init));
      final data = await appFetchApiRepo.getAttendanceDay(
          date: event.date,
          pupilId: currentUserBloc.state.user.pupil_id,
          classId: currentUserBloc.state.user.children.class_id,
          schoolId: currentUserBloc.state.user.school_id,
          schoolBrand: currentUserBloc.state.user.school_brand);
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.success, attendanceday: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }

  void _onGetAttendanceWeek(
      GetAttendanceWeek event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.init));
      final data = await appFetchApiRepo.getAttendanceWeek(
          pupilId: currentUserBloc.state.user.pupil_id,
          classId: currentUserBloc.state.user.children.class_id,
          schoolId: currentUserBloc.state.user.school_id,
          schoolBrand: currentUserBloc.state.user.school_brand,
          startDate: event.startDate,
          endDate: event.endDate);
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.success, attendanceWeek: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }

  void _onGetAttendanceMonth(
      GetAttendanceMonth event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.init));
      final data = await appFetchApiRepo.getAttendanceMonth(
          pupilId: currentUserBloc.state.user.pupil_id,
          classId: currentUserBloc.state.user.children.class_id,
          schoolId: currentUserBloc.state.user.school_id,
          schoolBrand: currentUserBloc.state.user.school_brand,
          startDate: event.startDate,
          endDate: event.endDate);
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.success, attendanceMonth: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }
}
