class AttendanceDataList {
  final int pupilId;
   String status;
  final int numberOfClassPeriod;
  final int classId;
  final int subjectId;

  AttendanceDataList({
    required this.pupilId,
    required this.status,
    required this.numberOfClassPeriod,
    required this.classId,
    required this.subjectId,
  });

  Map<String, dynamic> toJson() {
    return {
      'pupil_id': pupilId,
      'status': status,
      'number_of_class_period': numberOfClassPeriod,
      'class_id': classId,
      'subject_id': subjectId,
    };
  }
}
