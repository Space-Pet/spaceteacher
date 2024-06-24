import 'dart:convert';

class ViolationData {
  final List<PupilInfo> pupils;
  final TeacherLeader teacher;
  final ClassInfo classInfo;

  ViolationData({
    required this.pupils,
    required this.teacher,
    required this.classInfo,
  });

  factory ViolationData.fromMap(Map<String, dynamic> map) {
    return ViolationData(
      pupils: List<PupilInfo>.from(map['data']?.map((item) => PupilInfo.fromMap(item))),
      teacher: TeacherLeader.fromMap({
        'teacher_id': map['teacher_id'],
        'teacher_fullname': map['teacher_fullname'],
      }),
      classInfo: ClassInfo.fromMap({
        'class_id': map['class_id'],
        'class_name': map['class_name'],
      }),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': List<dynamic>.from(pupils.map((x) => x.toMap())),
      'teacher_id': teacher.teacherId,
      'teacher_fullname': teacher.teacherFullName,
      'class_id': classInfo.classId,
      'class_name': classInfo.className,
    };
  }

  factory ViolationData.fromJson(String source) =>
      ViolationData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ViolationData(pupils: $pupils, teacher: $teacher, classInfo: $classInfo)';
}

class PupilInfo {
  final String pupilId;
  final String pupilName;

  PupilInfo({
    required this.pupilId,
    required this.pupilName,
  });

  factory PupilInfo.fromMap(Map<String, dynamic> map) {
    return PupilInfo(
      pupilId: map['pupil_id'],
      pupilName: map['pupil_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pupil_id': pupilId,
      'pupil_name': pupilName,
    };
  }

  factory PupilInfo.fromJson(String source) => PupilInfo.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Pupil(pupilId: $pupilId, pupilName: $pupilName)';
}

class TeacherLeader {
  final String teacherId;
  final String teacherFullName;

  TeacherLeader({
    required this.teacherId,
    required this.teacherFullName,
  });

  factory TeacherLeader.fromMap(Map<String, dynamic> map) {
    return TeacherLeader(
      teacherId: map['teacher_id'],
      teacherFullName: map['teacher_fullname'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacher_id': teacherId,
      'teacher_fullname': teacherFullName,
    };
  }

  factory TeacherLeader.fromJson(String source) => TeacherLeader.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Teacher(teacherId: $teacherId, teacherFullName: $teacherFullName)';
}

class ClassInfo {
  final String classId;
  final String className;

  ClassInfo({
    required this.classId,
    required this.className,
  });

  factory ClassInfo.fromMap(Map<String, dynamic> map) {
    return ClassInfo(
      classId: map['class_id'],
      className: map['class_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class_id': classId,
      'class_name': className,
    };
  }

  factory ClassInfo.fromJson(String source) => ClassInfo.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ClassInfo(classId: $classId, className: $className)';
}
