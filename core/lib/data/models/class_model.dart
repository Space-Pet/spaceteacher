class ClassModel {
  const ClassModel({
    required this.classId,
    required this.className,
    required this.classLevel,
    required this.classLevelCode,
  });

  final String classId;
  final String className;
  final String classLevel;
  final String classLevelCode;

  factory ClassModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ClassModel(
      classId: map['class_id'] as String,
      className: map['class_name'] as String,
      classLevel: map['class_level'] as String,
      classLevelCode: map['class_level_code'] as String,
    );
  }

  @override
  String toString() {
    return 'ClassModel(classId: $classId, className: $className, classLevel: $classLevel, classLevelCode: $classLevelCode)';
  }
}
