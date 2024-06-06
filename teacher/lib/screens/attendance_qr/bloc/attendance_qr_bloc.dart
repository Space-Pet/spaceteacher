import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
part 'attendance_qr_event.dart';
part 'attendance_qr_state.dart';

class AttendanceQrBloc extends Bloc<AttendanceQrEvent, AttendanceQrState> {
  final AppFetchApiRepository appFetchApiRepository;
  final CurrentUserBloc currentUserBloc;
  AttendanceQrBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
  }) : super(const AttendanceQrState()) {
    on<GetListAttendance>(_onGetListAttendance);
    on<PostAttendance>(_onPostAttendance);
  }

  Future<void> _onPostAttendance(
    PostAttendance event,
    Emitter<AttendanceQrState> emit,
  ) async {
    emit(state.copyWith(
        attendanceQrStatus: AttendanceQrStatus.loadingPostAttendance));
    final data = await appFetchApiRepository.postAttendance(
      type: event.type,
      numberOfClasspriod: event.numberOfClasspriod,
      classId: event.classId,
      subject: event.subject,
      roomId: event.roomId,
      roomTitle: event.roomTitle,
      date: event.date,
      attendanceData: event.attendanceData,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    final int code = data?['code'];
    final String message = data?['message'];
    emit(state.copyWith(
        attendanceQrStatus: code == 200
            ? AttendanceQrStatus.successPostAttendance
            : AttendanceQrStatus.failPost,
        message: message));
  }

  Future<void> _onGetListAttendance(
    GetListAttendance event,
    Emitter<AttendanceQrState> emit,
  ) async {
    emit(state.copyWith(attendanceQrStatus: AttendanceQrStatus.loadingGetList));
    final data = await appFetchApiRepository.getListAttendance(
      classId: event.classId,
      numberOfClassPeriod: event.numberOfClassPeriod,
      subjectId: event.subjectId,
      date: event.date,
      type: event.type,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(state.copyWith(
      attendanceQrStatus: data != []
          ? AttendanceQrStatus.successGetList
          : AttendanceQrStatus.fail,
      listAttendance: data,
    ));
  }
}
