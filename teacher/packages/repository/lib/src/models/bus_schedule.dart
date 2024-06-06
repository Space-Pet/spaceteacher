import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_schedule.freezed.dart';

@freezed
class BusSchedule with _$BusSchedule {
  const factory BusSchedule({
    required int id,
    required int schoolId,
    required int scheduleId,
    required DateTime attendanceDate,
    required int? attendance,
    required String? checkOut,
    required String? checkIn,
    required Pupil pupil,
    required Route route,
    required AttendanceFeeType attendanceFeeType,
    required ScheduleType scheduleType,
    required BusStop busStop,
    required DriverInfo driverInfo,
    required Teacher teacher,
  }) = _BusSchedule;

  factory BusSchedule.fromData(BusScheduleData data) {
    return BusSchedule(
      id: data.id,
      schoolId: data.schoolId,
      scheduleId: data.scheduleId,
      attendanceDate: DateTime.parse(data.attendanceDate),
      attendance: data.attendance,
      checkOut: data.checkOut,
      checkIn: data.checkIn,
      pupil: Pupil.fromData(data.pupil),
      route: Route.fromData(data.route),
      attendanceFeeType: AttendanceFeeType.fromData(data.attendanceFeeType),
      scheduleType: ScheduleType.fromData(data.scheduleType),
      busStop: BusStop.fromData(data.busStop),
      driverInfo: DriverInfo.fromData(data.driverInfo),
      teacher: Teacher.fromData(data.teacher),
    );
  }
}

extension BusScheduleX on BusSchedule {
  bool get isPickup => scheduleType.value == 1;

  bool get isCompleted =>
      (checkIn ?? '').isNotEmpty && (checkOut ?? '').isNotEmpty;

  String estimatedTime() {
    return busStop.estimatedTime.hhMM;
  }

  String title() {
    const left = 'Học sinh lên - xuống xe:';
    return '$left${(checkIn ?? '').isNotEmpty ? ' ${checkIn?.substring(11, 16)} - ' : ''}${checkOut?.substring(11, 16) ?? ''}';
  }

  String attendanceDateString() {
    return attendanceDate.ddMMyyyyDash;
  }

  String pickupLocation() {
    return '${busStop.address}, ${route.routeName}';
  }
}

@freezed
class Pupil with _$Pupil {
  const factory Pupil({
    required int pupilId,
    required String pupilName,
  }) = _Pupil;

  factory Pupil.fromData(PupilData data) {
    return Pupil(
      pupilId: data.pupilId,
      pupilName: data.pupilName,
    );
  }
}

@freezed
class Route with _$Route {
  const factory Route({
    required int routeId,
    required String routeName,
  }) = _Route;

  factory Route.fromData(RouteData data) {
    return Route(
      routeId: data.routeId,
      routeName: data.routeName,
    );
  }
}

@freezed
class AttendanceFeeType with _$AttendanceFeeType {
  const factory AttendanceFeeType({
    required int id,
    required String text,
  }) = _AttendanceFeeType;

  factory AttendanceFeeType.fromData(AttendanceFeeTypeData data) {
    return AttendanceFeeType(
      id: data.id,
      text: data.text,
    );
  }
}

@freezed
class ScheduleType with _$ScheduleType {
  const factory ScheduleType({
    required int value,
    required String text,
  }) = _ScheduleType;

  factory ScheduleType.fromData(ScheduleTypeData data) {
    return ScheduleType(
      value: data.value,
      text: data.text,
    );
  }
}

@freezed
class BusStop with _$BusStop {
  const factory BusStop({
    required int id,
    required String name,
    required String address,
    required DateTime estimatedTime,
  }) = _BusStop;

  factory BusStop.fromData(BusStopData data) {
    return BusStop(
      id: data.id,
      name: data.name,
      address: data.address,
      estimatedTime: DateTime.parse(data.estimatedTime),
    );
  }
}

@freezed
class DriverInfo with _$DriverInfo {
  const factory DriverInfo({
    required int busId,
    required String subDriver,
    required String numberPlate,
    required String driverName,
  }) = _DriverInfo;

  factory DriverInfo.fromData(DriverInfoData data) {
    return DriverInfo(
      busId: data.busId,
      subDriver: data.subDriver,
      numberPlate: data.numberPlate,
      driverName: data.driverName,
    );
  }
}

@freezed
class Teacher with _$Teacher {
  const factory Teacher({
    required int teacherId,
    required String teacherName,
    required String mobilePhone,
    required UserImage image,
  }) = _Teacher;

  factory Teacher.fromData(TeacherData data) {
    return Teacher(
      teacherId: data.teacherId,
      teacherName: data.teacherName,
      mobilePhone: data.mobilePhone,
      image: UserImage.fromData(data.image),
    );
  }
}

@freezed
class UserImage with _$UserImage {
  const factory UserImage({
    required String web,
    required String mobile,
  }) = _UserImage;

  factory UserImage.fromData(ImageData data) {
    return UserImage(
      web: data.web,
      mobile: data.mobile,
    );
  }
}
