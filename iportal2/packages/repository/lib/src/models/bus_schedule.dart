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
    required RouteBus route,
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
      route: RouteBus.fromData(data.route),
      attendanceFeeType: AttendanceFeeType.fromData(data.attendanceFeeType),
      scheduleType: ScheduleType.fromData(data.scheduleType),
      busStop: BusStop.fromData(data.busStop),
      driverInfo: DriverInfo.fromData(data.driverInfo),
      teacher: Teacher.fromData(data.teacher),
    );
  }

  // create fakeData type  List<BusSchedule>
  static List<BusSchedule> fakeData() {
    return List.generate(
      2,
      (index) => BusSchedule(
        id: index,
        schoolId: 1,
        scheduleId: 1,
        attendanceDate: DateTime.now(),
        attendance: 1,
        checkOut: '2021-10-10T10:10:10',
        checkIn: '2021-10-10T10:10:10',
        pupil: const Pupil(pupilId: 1, pupilName: 'Nguyen Van A'),
        route: const RouteBus(routeId: 1, routeName: 'Route 1'),
        attendanceFeeType:
            const AttendanceFeeType(id: 1, text: 'AttendanceFeeType 1'),
        scheduleType: const ScheduleType(value: 1, text: 'ScheduleType 1'),
        busStop: BusStop(
          id: 1,
          name: 'BusStop 1',
          address: 'Address 1',
          estimatedTime: DateTime.now(),
        ),
        driverInfo: const DriverInfo(
          busId: 1,
          subDriver: 'SubDriver 1',
          numberPlate: 'NumberPlate 1',
          driverName: 'DriverName 1',
        ),
        teacher: const Teacher(
          teacherId: 1,
          teacherName: 'TeacherName 1',
          mobilePhone: 'MobilePhone 1',
          image: UserImage(
            web: 'Web 1',
            mobile: 'Mobile 1',
          ),
        ),
      ),
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

  String checkInTime() {
    if ((checkIn ?? '').isEmpty) {
      return '';
    }

    const left = 'Giờ lên:';
    return '$left ${checkIn?.substring(11, 16)}';
  }

  String checkOutTime() {
    if ((checkOut ?? '').isEmpty) {
      return '';
    }

    const left = 'Giờ xuống:';
    return '$left ${checkOut?.substring(11, 16)}';
  }

  String attendanceDateString() {
    return attendanceDate.ddMMyyyySlash;
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
class RouteBus with _$RouteBus {
  const factory RouteBus({
    required int routeId,
    required String routeName,
  }) = _RouteBus;

  factory RouteBus.fromData(RouteData data) {
    return RouteBus(
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
