class ClassScore {
  final int classId;
  final String classTitle;
  final String capDaoTao;
  final int subjectId;
  final String subjectName;
  final String titel;
  const ClassScore({
    required this.capDaoTao,
    required this.classId,
    required this.classTitle,
    required this.subjectId,
    required this.subjectName,
    required this.titel,
  });
  factory ClassScore.fromJson(Map<String, dynamic> json) {
    return ClassScore(
      capDaoTao: json['cap_dao_tao'] ?? '',
      classId: json['class_id'] ?? 0,
      classTitle: json['class_title'] ?? '',
      subjectId: json['subject_id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      titel: json['title'] ?? '',
    );
  }
}
