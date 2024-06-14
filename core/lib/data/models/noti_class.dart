import 'dart:convert';

class NotiClass {
  int classId;
  int gradeId;
  int schoolId;
  String className;
  String gradeTitle;
  String title;
  String code;
  String level;
  int roomId;
  String? roomTitle;
  dynamic selected;

  NotiClass({
    required this.classId,
    required this.gradeId,
    required this.schoolId,
    required this.className,
    required this.gradeTitle,
    required this.title,
    required this.code,
    required this.level,
    required this.roomId,
    this.roomTitle,
    this.selected,
  });

  factory NotiClass.fromMap(Map<String, dynamic> map) {
    return NotiClass(
      classId: map['class_id'],
      gradeId: map['grade_id'],
      schoolId: map['school_id'],
      className: map['class_name'],
      gradeTitle: map['grade_title'],
      title: map['title'],
      code: map['code'],
      level: map['level'],
      roomId: map['room_id'],
      roomTitle: map['room_title'],
      selected: map['selected'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class_id': classId,
      'grade_id': gradeId,
      'school_id': schoolId,
      'class_name': className,
      'grade_title': gradeTitle,
      'title': title,
      'code': code,
      'level': level,
      'room_id': roomId,
      'room_title': roomTitle,
      'selected': selected,
    };
  }

  factory NotiClass.fromJson(String json) {
    final map = jsonDecode(json);
    return NotiClass.fromMap(map);
  }

  String toJson() {
    final map = toMap();
    return jsonEncode(map);
  }

  factory NotiClass.empty() {
    return NotiClass(
      classId: 0,
      gradeId: 0,
      schoolId: 0,
      className: 'Chọn lớp',
      gradeTitle: '',
      title: 'Chọn lớp',
      code: '',
      level: '',
      roomId: 0,
    );
  }
}
