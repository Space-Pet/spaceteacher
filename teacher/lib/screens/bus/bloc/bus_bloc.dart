import 'package:core/core.dart';
import 'package:core/data/models/list_attendance_bus.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  BusBloc({
    required this.appFetchApiRepository,
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(BusState(
          selectedDate: DateTime.now(),
          userData: TeacherDetail.empty(),
        )) {
    on<BusChangedDate>(_onChangedDate);
    on<BusFetchProfileData>(_onFetchTeacherDetail);
    add(BusFetchProfileData());
    on<DetailBus>(_onDetailBusSchedule);
    add(BusChangedDate(date: DateTime.now().yyyyMMdd));
    on<GetListAttendanceBus>(_onListAttendanceBus);

    on<PostTakeAttendanceOfEachStudent>(_onPostTakeAttendanceOfEachStudent);
    on<PostUpdateAbsentBus>(_onPostUpdateAvsentBus);
  }
  final AppFetchApiRepository appFetchApiRepository;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  void _onPostUpdateAvsentBus(
    PostUpdateAbsentBus event,
    Emitter<BusState> emit,
  ) async {
    emit(state.copyWith(status: BusStatus.loadingPost));
    final data = await appFetchApiRepository.postUpdateAbsentBus(
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id,
      pupilId: event.pupilId,
      attendanceId: event.attendanceId,
      scheduleId: event.scheduleId,
    );
    final code = data['code'];
    final message = data['message'];
    emit(state.copyWith(
      status: code == 200 ? BusStatus.successPost : BusStatus.failure,
      message: message,
    ));
  }

  void _onPostTakeAttendanceOfEachStudent(
    PostTakeAttendanceOfEachStudent event,
    Emitter<BusState> emit,
  ) async {
    emit(state.copyWith(status: BusStatus.loadingPost));
    final data = await appFetchApiRepository.postTakeAttendanceOfEachStudent(
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id,
      pupilId: event.pupilId,
      type: event.type,
      attendanceId: event.attendanceId,
      scheduleId: event.scheduleId,
    );
    final code = data['code'];
    final message = data['message'];
    emit(state.copyWith(
      status: code == 200 ? BusStatus.successPost : BusStatus.failure,
      message: message,
    ));
  }

  void _onListAttendanceBus(
    GetListAttendanceBus event,
    Emitter<BusState> emit,
  ) async {
    emit(state.copyWith(status: BusStatus.loading));
    final data = await appFetchApiRepository.getListAttendanceBus(
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id,
      busId: event.busId,
    );
    final List<Pupils> listPupils = [];
    Pupils? pupilWithNullCheckIn;
    Pupils? pupilWithNullCheckOut;
    Pupils? pupilToDisplay;
    String type = '';

    for (var item in data) {
      for (var intemPupil in item.pupils ?? []) {
        listPupils.add(intemPupil);
      }
    }

    for (var pupil in listPupils) {
      if (pupil.checkIn == null && pupil.attendance != 0) {
        pupilWithNullCheckIn = pupil;
        type = 'check_in';
        break;
      }
    }

    if (pupilWithNullCheckIn == null) {
      for (var pupil in listPupils) {
        if (pupil.checkOut == null && pupil.attendance != 0) {
          pupilWithNullCheckOut = pupil;
          type = 'check_out';
          break;
        }
      }
    }
    pupilToDisplay = pupilWithNullCheckIn ?? pupilWithNullCheckOut;
    emit(state.copyWith(
      status: data.isNotEmpty
          ? BusStatus.successGetListAttendance
          : BusStatus.failure,
      listAttendanceBus: pupilToDisplay,
      type: type,
    ));
  }

  void _onFetchTeacherDetail(
    BusFetchProfileData event,
    Emitter<BusState> emit,
  ) async {
    emit(state.copyWith(status: BusStatus.init));
    final teacherDetail = await userRepository
        .getTeacherDetail(currentUserBloc.state.user.teacher_id.toString());

    emit(state.copyWith(
      status: BusStatus.success,
      userData: teacherDetail,
    ));
  }

  _onDetailBusSchedule(
    DetailBus event,
    Emitter<BusState> emit,
  ) async {
    emit(state.copyWith(status: BusStatus.loading));
    try {
      final data = await appFetchApiRepository.getDetailBusSchedule(
        schoolBrand: currentUserBloc.state.user.school_brand,
        schoolId: currentUserBloc.state.user.school_id,
        idBus: event.idBus,
      );
      emit(state.copyWith(status: BusStatus.success, detailBusSchedule: data));
    } catch (e) {
      emit(state.copyWith(status: BusStatus.failure));
    }
  }

  _onChangedDate(
    BusChangedDate event,
    Emitter<BusState> emit,
  ) async {
    emit(state.copyWith(status: BusStatus.loading));

    final busSchedules = await appFetchApiRepository.getBusScheduleTeacher(
      endDate: event.date,
      startDate: event.date,
      schoolBrand: currentUserBloc.state.user.school_brand,
      schoolId: currentUserBloc.state.user.school_id,
    );
    emit(state.copyWith(
      busSchedules: busSchedules,
      status: BusStatus.success,
    ));
  }
}
