import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
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
      : super(const AttendanceState()) {
    on<GetAttendanceDay>(_onGetAttendanceDay);
    on<GetAttendanceWeek>(_onGetAttendanceWeek);
    on<GetAttendanceMonth>(_onGetAttendanceMonth);
    on<GetAttendanceType>(_onGetType);
    add(GetAttendanceType());
  }
  void _onGetType(
      GetAttendanceType event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.initType));
      final data = await appFetchApiRepo.getAttendanceType(
          schoolId: currentUserBloc.state.activeChild.school_id,
          schoolBrand: currentUserBloc.state.activeChild.school_brand);
      emit(state.copyWith(
          type: data, attendanceStatus: AttendanceStatus.successType));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }

  void _onGetAttendanceDay(
      GetAttendanceDay event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.init, date: DateTime.now()));
      final user = currentUserBloc.state.activeChild;

      final data = await appFetchApiRepo.getAttendanceDay(
        type: state.type ?? '',
        date: event.date,
        pupilId: user.pupil_id,
        classId: user.class_id,
        schoolId: user.school_id,
        schoolBrand: user.school_brand,
      );

      emit(state.copyWith(
        attendanceStatus: AttendanceStatus.success,
        attendanceday: data,
        date: event.selectDate,
      ));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }

  void _onGetAttendanceWeek(
      GetAttendanceWeek event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(
        attendanceStatus: AttendanceStatus.initWeek,
      ));
      final data = await appFetchApiRepo.getAttendanceWeek(
          pupilId: currentUserBloc.state.activeChild.pupil_id,
          classId: currentUserBloc.state.user.children[0].class_id,
          schoolId: currentUserBloc.state.activeChild.school_id,
          schoolBrand: currentUserBloc.state.activeChild.school_brand,
          startDate: event.startDate,
          endDate: event.endDate);
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.successMonth,
          attendanceWeek: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }

  void _onGetAttendanceMonth(
      GetAttendanceMonth event, Emitter<AttendanceState> emit) async {
    try {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.initMonth));
      final data = await appFetchApiRepo.getAttendanceMonth(
          pupilId: currentUserBloc.state.activeChild.pupil_id,
          classId: currentUserBloc.state.user.children[0].class_id,
          schoolId: currentUserBloc.state.activeChild.school_id,
          schoolBrand: currentUserBloc.state.activeChild.school_brand,
          startDate: event.startDate,
          endDate: event.endDate);
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.successMonth,
          attendanceMonth: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.error));
    }
  }
}
