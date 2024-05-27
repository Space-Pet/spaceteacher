import 'dart:convert';

import 'teacher_detail.dart';

class TeacherLogin {
  final String name;
  final String userKey;
  final int userId;
  final int schoolId;
  final int type;
  final String typeText;
  final int teacherId;
  final String schoolName;
  final String schoolLogo;
  final String schoolBrand;
  final int? semester;
  final String learnYear;
  final String email;
  final CapDaoTao capDaoTao;

  TeacherLogin({
    required this.name,
    required this.userKey,
    required this.userId,
    required this.schoolId,
    required this.type,
    required this.typeText,
    required this.teacherId,
    required this.schoolName,
    required this.schoolLogo,
    required this.schoolBrand,
    this.semester,
    required this.learnYear,
    required this.email,
    required this.capDaoTao,
  });

  // 'C_002' KinderGarten
  // 'C_003' Primary School
  // 'C_004' Secondary School
  bool isKinderGarten() {
    return capDaoTao.id == 'C_002';
  }

  factory TeacherLogin.fromMap(Map<String, dynamic> map) {
    return TeacherLogin(
      name: map['name'],
      userKey: map['user_key'],
      userId: map['user_id'],
      schoolId: map['school_id'],
      type: map['type'],
      typeText: map['type_text'],
      teacherId: map['teacher_id'],
      schoolName: map['school_name'],
      schoolLogo: map['school_logo'],
      schoolBrand: map['school_brand'],
      semester: map['semester'],
      learnYear: map['learn_year'],
      email: map['email'],
      capDaoTao: CapDaoTao.fromMap(map['cap_dao_tao']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user_key': userKey,
      'user_id': userId,
      'school_id': schoolId,
      'type': type,
      'type_text': typeText,
      'teacher_id': teacherId,
      'school_name': schoolName,
      'school_logo': schoolLogo,
      'school_brand': schoolBrand,
      'semester': semester,
      'learn_year': learnYear,
      'email': email,
      'cap_dao_tao': capDaoTao.toMap(),
    };
  }

  factory TeacherLogin.fromJson(String json) {
    return TeacherLogin.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory TeacherLogin.empty() {
    return TeacherLogin(
      name: '',
      userKey: '',
      userId: 0,
      schoolId: 0,
      type: 0,
      typeText: '',
      teacherId: 0,
      schoolName: '',
      schoolLogo: '',
      schoolBrand: '',
      semester: 0,
      learnYear: '',
      email: '',
      capDaoTao: CapDaoTao(id: '', name: ''),
    );
  }
}
