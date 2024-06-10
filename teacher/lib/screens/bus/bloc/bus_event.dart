part of 'bus_bloc.dart';

@immutable
sealed class BusEvent {}

class BusFetchedSchedules extends BusEvent {}

class BusChangedDate extends BusEvent {
  final String date;
  final DateTime selectDate;
  BusChangedDate({
    required this.date,
    required this.selectDate,
  });
}

class DetailBus extends BusEvent {
  final int idBus;
  DetailBus({required this.idBus});
}

class BusFetchProfileData extends BusEvent {
  BusFetchProfileData();
}

class GetListAttendanceBus extends BusEvent {
  final int busId;
  GetListAttendanceBus({required this.busId});
}

class PostTakeAttendanceOfEachStudent extends BusEvent {
  final int attendanceId;
  final int scheduleId;
  final String type;
  final int pupilId;
  PostTakeAttendanceOfEachStudent({
    required this.attendanceId,
    required this.pupilId,
    required this.scheduleId,
    required this.type,
  });
}

class PostUpdateAbsentBus extends BusEvent {
  final int pupilId;
  final int attendanceId;
  final int scheduleId;
  PostUpdateAbsentBus({
    required this.attendanceId,
    required this.pupilId,
    required this.scheduleId,
  });
}

class GetEditAttendance extends BusEvent {
  final int busId;
  GetEditAttendance({required this.busId});
}

class PostEditAttendance extends BusEvent {
  final String type;
  final int scheduleIdl;
  final List<Map<String, dynamic>> listEdit;
  PostEditAttendance({
    required this.listEdit,
    required this.scheduleIdl,
    required this.type,
  });
}
