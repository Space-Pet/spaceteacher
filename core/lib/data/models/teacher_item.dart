import 'dart:convert';

class TeacherItem {
  final String? teacherId;
  final String? teacherUserKey;
  final String? teacherFullname;
  final String? teacherImg;
  final String? teacherMainSubjectId;
  final String? teacherMainSubjectName;
  final String? teacherEmail;
  final String? teacherMobile;
  TeacherItem({
    this.teacherId,
    this.teacherUserKey,
    this.teacherFullname,
    this.teacherImg,
    this.teacherMainSubjectName,
    this.teacherMainSubjectId,
    this.teacherEmail,
    this.teacherMobile,
  });

  TeacherItem copyWith({
    String? teacherId,
    String? teacherUserKey,
    String? teacherFullname,
    String? teacherImg,
    String? teacherMainSubjectId,
    String? teacherMainSubjectName,
    String? teacherEmail,
    String? teacherMobile,
  }) {
    return TeacherItem(
      teacherId: teacherId ?? this.teacherId,
      teacherUserKey: teacherUserKey ?? this.teacherUserKey,
      teacherFullname: teacherFullname ?? this.teacherFullname,
      teacherImg: teacherImg ?? this.teacherImg,
      teacherMainSubjectId: teacherMainSubjectId ?? this.teacherMainSubjectId,
      teacherMainSubjectName:
          teacherMainSubjectName ?? this.teacherMainSubjectName,
      teacherEmail: teacherEmail ?? this.teacherEmail,
      teacherMobile: teacherMobile ?? this.teacherMobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacher_id': teacherId,
      'teacher_user_key': teacherUserKey,
      'teacher_fullname': teacherFullname,
      'teacher_img': teacherImg,
      'teacher_main_subject_id': teacherMainSubjectId,
      'teacher_main_subject_name': teacherMainSubjectName,
      'teacher_email': teacherEmail,
      'teacher_mobile': teacherMobile,
    };
  }

  factory TeacherItem.fromMap(Map<String, dynamic> map) {
    return TeacherItem(
      teacherId: map['teacher_id'] as String?,
      teacherUserKey: map['teacher_user_key'] as String?,
      teacherFullname: map['teacher_fullname'] as String?,
      teacherImg: map['teacher_img'] as String?,
      teacherMainSubjectId: map['teacher_main_subject_id'] as String?,
      teacherMainSubjectName: map['teacher_main_subject_name'] as String?,
      teacherEmail: map['teacher_email'] as String?,
      teacherMobile: map['teacher_mobile'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherItem.fromJson(Map<String, dynamic> json) =>
      TeacherItem.fromMap(json);

  @override
  String toString() {
    return 'TeacherItem(teacher_id: $teacherId, teacher_user_key: $teacherUserKey, teacher_fullname: $teacherFullname, teacher_img: $teacherImg, teacher_main_subject_id: $teacherMainSubjectId, teacher_main_subject_name: $teacherMainSubjectName, teacher_email: $teacherEmail, teacher_mobile: $teacherMobile)';
  }
}
