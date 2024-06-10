import 'dart:convert';

class TeacherItem {
  final String teacherId;
  final String teacherUserKey;
  final String teacherFullname;
  final String? teacherImg;
  final String teacherMainSubjectId;
  final String teacherMainSubjectName;
  final String teacherEmail;
  final String teacherMobile;
  TeacherItem({
    required this.teacherId,
    required this.teacherUserKey,
    required this.teacherFullname,
    this.teacherImg,
    required this.teacherMainSubjectName,
    required this.teacherMainSubjectId,
    required this.teacherEmail,
    required this.teacherMobile,
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
      teacherId: map['teacher_id'] as String,
      teacherUserKey: map['teacher_user_key'] as String,
      teacherFullname: map['teacher_fullname'] as String,
      teacherImg: map['teacher_img'] as String?,
      teacherMainSubjectId: map['teacher_main_subject_id'] as String,
      teacherMainSubjectName: map['teacher_main_subject_name'] as String,
      teacherEmail: map['teacher_email'] as String,
      teacherMobile: map['teacher_mobile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherItem.fromJson(String source) =>
      TeacherItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherItem(teacher_id: $teacherId, teacher_user_key: $teacherUserKey, teacher_fullname: $teacherFullname, teacher_img: $teacherImg, teacher_main_subject_id: $teacherMainSubjectId, teacher_main_subject_name: $teacherMainSubjectName, teacher_email: $teacherEmail, teacher_mobile: $teacherMobile)';
  }
}

final List<TeacherItem> mockTeacherItems = [
  TeacherItem(
    teacherId: '10005975',
    teacherUserKey: 'trinhttm.ukaheadoffice',
    teacherFullname: 'Trần Thị Mộng Trinh',
    teacherImg: null,
    teacherMainSubjectId: '34',
    teacherMainSubjectName: 'IELTS-Foreign teacher',
    teacherEmail: 'trinhttm@nhg.vn',
    teacherMobile: '',
  ),
  TeacherItem(
      teacherId: '10006023',
      teacherUserKey: 'tuanhm.ukaheadoffice',
      teacherFullname: 'Huỳnh Minh Tuấn',
      teacherImg:
          'https://iportal.nhg.vn/webservice/thumb_v3.php?file=dXBsb2FkL3RlYWNoZXIvMjAyMi8wNC8xNjUyNDM0OTQ4LTYyNTU0OTg0NzI4NDYuanBlZw==&width=100&height=100',
      teacherMainSubjectId: '34',
      teacherMainSubjectName: 'IELTS-Foreign teacher',
      teacherEmail: 'tuanhm01@uka.edu.vn',
      teacherMobile: '0399922722'),
  TeacherItem(
    teacherId: '10006137',
    teacherUserKey: 'anhttn.ukaheadoffice',
    teacherFullname: 'Trần Thị Ngọc Anh',
    teacherImg:
        'https://iportal.nhg.vn/webservice/thumb_v3.php?file=dXBsb2FkL3RlYWNoZXIvMjAyMy8wNC8xNjgzMDIyNDY5LTY0MjgwNDA1YWViZjAucG5n&width=100&height=100',
    teacherMainSubjectId: '34',
    teacherMainSubjectName: 'IELTS-Foreign teacher',
    teacherEmail: 'anhttn@uka.edu.vn',
    teacherMobile: '',
  ),
  TeacherItem(
    teacherId: '10006611',
    teacherUserKey: 'hann.ukaheadoffice',
    teacherFullname: 'Ngô Nhị Hà',
    teacherImg: null,
    teacherMainSubjectId: '34',
    teacherMainSubjectName: 'IELTS-Foreign teacher',
    teacherEmail: 'hann01@uka.edu.vn',
    teacherMobile: '',
  ),
  TeacherItem(
    teacherId: '10006641',
    teacherUserKey: 'tamdt.ukaheadoffice',
    teacherFullname: 'Đặng Thiên Tâm',
    teacherImg: null,
    teacherMainSubjectId: '34',
    teacherMainSubjectName: 'IELTS-Foreign teacher',
    teacherEmail: 'tamdt.binhthanh@uka.edu.vn',
    teacherMobile: '',
  ),
  TeacherItem(
    teacherId: '10007205',
    teacherUserKey: 'phuntn1.ukaheadoffice',
    teacherFullname: 'Nguyễn Thị Ngọc Phú',
    teacherImg: null,
    teacherMainSubjectId: '22',
    teacherMainSubjectName: 'School assembly - SHTT',
    teacherEmail: 'phuntn@nhg.vn',
    teacherMobile: '',
  ),
  TeacherItem(
    teacherId: '10007310',
    teacherUserKey: 'hanghtt.ukaheadoffice',
    teacherFullname: 'Huỳnh Thị Thanh Hằng',
    teacherImg: null,
    teacherMainSubjectId: '22',
    teacherMainSubjectName: 'School assembly - SHTT',
    teacherEmail: 'hanghtt01@nhg.vn',
    teacherMobile: '',
  ),
  TeacherItem(
    teacherId: '10007807',
    teacherUserKey: 'thaotnt.ukaheadoffice',
    teacherFullname: 'Trần Ngọc Thanh Thảo',
    teacherImg: null,
    teacherMainSubjectId: '22',
    teacherMainSubjectName: 'School assembly - SHTT',
    teacherEmail: 'thaotnt@uka.edu.vn',
    teacherMobile: '',
  )
];
