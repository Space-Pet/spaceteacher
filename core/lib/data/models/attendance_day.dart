class AttendanceDay {
  final int id;
  final String date;
  final int subjectId;
  final String attendanceType;
  final String subjectName;
  final String numberOfClassPeriod;
  final String status;
  final int roomId;
  final String roomTitle;
  final String teacherName;

  const AttendanceDay({
    required this.roomId,
    required this.date,
    required this.id,
    required this.numberOfClassPeriod,
    required this.roomTitle,
    required this.status,
    required this.attendanceType,
    required this.subjectId,
    required this.subjectName,
    required this.teacherName,
  });

  factory AttendanceDay.fromJson(Map<String, dynamic> json) {
    return AttendanceDay(
      roomId: json['room_id'] ?? 0,
      attendanceType: json['attendance_type'] ?? '',
      date: json['date'] ?? '',
      id: json['id'] ?? 0,
      numberOfClassPeriod: json['number_of_class_period'] ?? '',
      roomTitle: json['room_title'] ?? '',
      status: json['status'] ?? '',
      subjectId: json['subject_id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      teacherName: json['teacher_name'] ?? '',
    );
  }

  static List<AttendanceDay> fakeData = List.generate(
      10,
      (index) => AttendanceDay(
            roomId: index,
            date: '2022-09-0$index',
            id: index,
            numberOfClassPeriod: '10',
            roomTitle: 'Room $index',
            status: 'Có mặt',
            attendanceType: 'so_lan',
            subjectId: index,
            subjectName: 'Subject $index',
            teacherName: 'Teacher $index',
          ));
}
