import 'package:network_data_source/network_data_source.dart';

class StudentData {
  final Pupil pupil;
  final ClassInfo classInfo;
  final School school;
  final Parent parent;

  StudentData({
    required this.pupil,
    required this.classInfo,
    required this.school,
    required this.parent,
  });
  factory StudentData.fromMap(Map<String, dynamic> json) {
    final pupil = Pupil.fromJson(json['pupil']);
    final classInfo = ClassInfo.fromJson(json['class']);
    final school = School.fromJson(json['school']);
    final parent = Parent.fromJson(json['parent']);

    return StudentData(
      pupil: pupil,
      classInfo: classInfo,
      school: school,
      parent: parent,
    );
  }
}

class Pupil {
  final int pupilId;
  final String name;
  final String userId;
  final String userKey;
  final String learnYear;
  final int customerId;
  final String birthday;
  final String address;
  final String phone;
  final String email;
  final int status;
  final String statusText;

  Pupil({
    required this.pupilId,
    required this.name,
    required this.userId,
    required this.userKey,
    required this.learnYear,
    required this.customerId,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.email,
    required this.status,
    required this.statusText,
  });
  factory Pupil.fromJson(Map<String, dynamic> json) {
    return Pupil(
        pupilId: json['pupil_id'] ?? 0,
        name: json['name'] ?? '',
        userId: json['user_id'] ?? '',
        userKey: json['user_key'] ?? '',
        learnYear: json['learn_year'] ?? '',
        customerId: json['customer_id'] ?? 0,
        birthday: json['birthday'] ?? '',
        address: json['address'] ?? '',
        phone: json['phone'] ?? '',
        email: json['email'] ?? '',
        status: json['status'] ?? 0,
        statusText: json['status_text'] ?? '');
  }
}

class ClassInfo {
  final int classId;
  final String name;

  ClassInfo({
    required this.classId,
    required this.name,
  });
  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(classId: json['class_id'] ?? 0, name: json['name'] ?? '');
  }
}

class School {
  final int schoolId;
  final String name;

  School({
    required this.schoolId,
    required this.name,
  });
  factory School.fromJson(Map<String, dynamic> json) {
    return School(schoolId: json['school_iod'] ?? 0, name: json['name'] ?? '');
  }
}

class Parent {
  final int parentId;
  final String motherName;
  final String motherPhone;
  final String fatherName;
  final String fatherPhone;

  Parent({
    required this.parentId,
    required this.motherName,
    required this.motherPhone,
    required this.fatherName,
    required this.fatherPhone,
  });
  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
        parentId: json['parent_id'] ?? 0,
        motherName: json['mother_name'] ?? '',
        motherPhone: json['mother_phone'] ?? '',
        fatherName: json['father_name'] ?? '',
        fatherPhone: json['father_phone'] ?? '');
  }
}
