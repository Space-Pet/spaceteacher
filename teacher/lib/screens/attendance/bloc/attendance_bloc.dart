import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AppFetchApiRepository appFetchApiRepository;
  final CurrentUserBloc currentUserBloc;

  AttendanceBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
  }) : super(AttendanceState()) {
    on<GetListClass>(_onGetListClass);
    on<GetAttendanceWeek>(_onGetAttendanceWeek);
    on<GetAttendanceMonth>(_onGetAttendanceMonth);
    on<GetAttendanceDay>(_onGetAttendanceDay);
    on<ShowScreen>(_onShowScreen);
    on<GetAttendanceClassTeacher>(_onGetAttendanceClassTeacher);
    on<GetAttendanceClassLeader>(_onGetAttendanceClassLeader);
    add(GetListClass());
    add(
      GetAttendanceClassTeacher(
        date: DateFormat('yyyy-MM-dd').format(
          DateTime.now(),
        ),
      ),
    );
    add(
      GetAttendanceClassLeader(
        date: DateFormat('yyyy-MM-dd').format(
          DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _onGetAttendanceClassLeader(
    GetAttendanceClassLeader event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(
        attendanceStatus: AttendanceStatus.loadingAttendanceClassLeader));
    final data = await appFetchApiRepository.getAttendanceClassLeader(
      date: event.date,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(
      state.copyWith(
        attendanceStatus: data != []
            ? AttendanceStatus.successAttendanceClassLeader
            : AttendanceStatus.fail,
        attendanceClassLeader: data,
      ),
    );
  }

  Future<void> _onGetAttendanceClassTeacher(
    GetAttendanceClassTeacher event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(
        attendanceStatus: AttendanceStatus.loadingAttendanceClassTeacher));
    final data = await appFetchApiRepository.getAttendanceClassTeacher(
      date: event.date,
      schoolId: currentUserBloc.state.user.school_id,
      schoolBrand: currentUserBloc.state.user.school_brand,
    );
    emit(
      state.copyWith(
        attendanceStatus: data != []
            ? AttendanceStatus.successAttendanceClassTeacher
            : AttendanceStatus.fail,
        attendanceClassTeacher: data,
      ),
    );
  }

  Future<void> _onShowScreen(
    ShowScreen event,
    Emitter<AttendanceState> emit,
  ) async {
    final classTeacher = state.classTeacher;
    if (classTeacher.isEmpty) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.failClass));
    } else {
      emit(state.copyWith(showScreen: event.showScreen));
      await _onGetAttendanceWeek(
        GetAttendanceWeek(
          classId: classTeacher.first.classId,
          startDate: event.startDateWeek ?? '',
          endDate: event.endDateWeek ?? '',
        ),
        emit,
      );
      await _onGetAttendanceMonth(
        GetAttendanceMonth(
          classId: classTeacher.first.classId,
          startDate: event.startDateMonth ?? '',
          endDate: event.endDateMonth ?? '',
        ),
        emit,
      );
      await _onGetAttendanceDay(
        GetAttendanceDay(
          classId: classTeacher.first.classId,
          startDate: event.dateDay ?? '',
          endDate: event.dateDay ?? '',
        ),
        emit,
      );
    }
  }

  Future<void> _onGetAttendanceDay(
    GetAttendanceDay event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(
        attendanceStatus: AttendanceStatus.loadingAttendanceDay));
    try {
      final data = await appFetchApiRepository.getAttendanceWeekTeacher(
        classId: event.classId,
        startDate: event.startDate,
        endDate: event.endDate,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
      );
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.successAttendanceDay,
          attendanceDay: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.failDay));
    }
  }

  Future<void> _onGetAttendanceMonth(
    GetAttendanceMonth event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(
        attendanceStatus: AttendanceStatus.loadingAttendanceMonth));
    try {
      final data = await appFetchApiRepository.getAttendanceWeekTeacher(
        classId: event.classId,
        startDate: event.startDate,
        endDate: event.endDate,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
      );
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.successAttendanceMonth,
          attendanceMonth: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.failMotnth));
    }
  }

  Future<void> _onGetAttendanceWeek(
    GetAttendanceWeek event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(
        attendanceStatus: AttendanceStatus.loadingAttendanceWeek));
    try {
      final data = await appFetchApiRepository.getAttendanceWeekTeacher(
        classId: event.classId,
        startDate: event.startDate,
        endDate: event.endDate,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
      );
      emit(state.copyWith(
        attendanceStatus: AttendanceStatus.successAttendanceWeek,
        attendanceWeek: data,
        startDate: event.startDate,
        endDate: event.endDate,
      ));
    } catch (e) {
      print('error');
      emit(state.copyWith(attendanceStatus: AttendanceStatus.failWeek));
    }
  }

  Future<void> _onGetListClass(
    GetListClass event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(attendanceStatus: AttendanceStatus.loadingClass));
    try {
      final data = await appFetchApiRepository.getListClassTeacher(
        teacherId: currentUserBloc.state.user.teacher_id,
        schoolId: currentUserBloc.state.user.school_id,
        schoolBrand: currentUserBloc.state.user.school_brand,
      );
      emit(state.copyWith(
          attendanceStatus: AttendanceStatus.successClass, classTeacher: data));
    } catch (e) {
      emit(state.copyWith(attendanceStatus: AttendanceStatus.failClass));
    }
  }
}
