class ListClassLeader {
  final String teacherId;
  final String teacherName;
  final List<ClassCnData> classCnData;

  ListClassLeader({
    required this.classCnData,
    required this.teacherId,
    required this.teacherName,
  });

  factory ListClassLeader.fromJson(Map<String, dynamic> json) {
    final classCnDataJson = json['class_cn_data'] as List? ?? [];
    final classData = <ClassCnData>[];
    if (classCnDataJson.isNotEmpty) {
      for (final element in classCnDataJson) {
        final data = ClassCnData.fromJson(element);
        if (data != null) {
          classData.add(data);
        }
      }
    }
    return ListClassLeader(
      classCnData: classData,
      teacherId: json['teacher_id'] ?? '',
      teacherName: json['teacher_name'] ?? '',
    );
  }

  factory ListClassLeader.empty() => ListClassLeader(
        classCnData: [],
        teacherId: '',
        teacherName: '',
      );

  bool get isEmpty => classCnData.isEmpty && teacherId.isEmpty && teacherName.isEmpty;

  bool get isNotEmpty => classCnData.isNotEmpty || teacherId.isNotEmpty || teacherName.isNotEmpty;
}

class ClassCnData {
  final String classId;
  final String className;
  final String classLevel;

  ClassCnData({
    required this.classId,
    required this.classLevel,
    required this.className,
  });

  factory ClassCnData.fromJson(Map<String, dynamic> json) {
    return ClassCnData(
      classId: json['class_id'] ?? '',
      classLevel: json['class_level'] ?? '',
      className: json['class_name'] ?? '',
    );
  }

  factory ClassCnData.empty() => ClassCnData(
        classId: '',
        classLevel: '',
        className: '',
      );

  bool get isEmpty => classId.isEmpty && classLevel.isEmpty && className.isEmpty;

  bool get isNotEmpty => classId.isNotEmpty || classLevel.isNotEmpty || className.isNotEmpty;
}
