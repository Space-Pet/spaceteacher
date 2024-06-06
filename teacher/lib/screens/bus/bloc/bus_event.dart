part of 'bus_bloc.dart';

@immutable
sealed class BusEvent {}

class BusFetchedSchedules extends BusEvent {}

class BusChangedDate extends BusEvent {
  final String date;
  BusChangedDate({
    required this.date,
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
