class StudentData {
  final Pupil pupil;
  final ClassInfo classInfo;
  final School school;
  final Parent parent;
  final Avatar avatar;
  final UserTrainingLevel trainingLevel;

  StudentData({
    required this.pupil,
    required this.classInfo,
    required this.school,
    required this.parent,
    required this.avatar,
    required this.trainingLevel,
  });

  factory StudentData.fromMap(Map<String, dynamic> json) {
    final pupil = Pupil.fromJson(json['pupil']);
    final classInfo = ClassInfo.fromJson(json['class']);
    final school = School.fromJson(json['school']);
    final parent = Parent.fromJson(json['parent']);
    final avatar = Avatar.fromJson(json['avatar']);
    final trainingLevel = UserTrainingLevel.fromJson(json['cap_dao_tao']);

    return StudentData(
      pupil: pupil,
      classInfo: classInfo,
      school: school,
      parent: parent,
      avatar: avatar,
      trainingLevel: trainingLevel,
    );
  }

  static empty() {
    return StudentData(
      pupil: Pupil(
        pupilId: 0,
        name: '',
        userId: '',
        userKey: '',
        learnYear: '',
        customerId: 0,
        birthday: '',
        address: '',
        phone: '',
        email: '',
        status: 0,
        statusText: '',
        identifier: '',
      ),
      classInfo: ClassInfo(classId: 0, name: ''),
      school: School(schoolId: 0, name: ''),
      parent: Parent(
        parentId: 0,
        motherName: '',
        motherPhone: '',
        fatherName: '',
        fatherPhone: '',
      ),
      avatar: Avatar(
        web: '',
        mobile: '',
      ),
      trainingLevel: UserTrainingLevel(
        id: '',
        name: '',
      ),
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
  final String identifier;

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
    required this.identifier,
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
      statusText: json['status_text'] ?? '',
      identifier: json['identifier'] ?? '',
    );
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
    return School(
      schoolId: json['school_iod'] ?? 0,
      name: json['name'] ?? '',
    );
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

class Avatar {
  final String web;
  final String mobile;

  Avatar({
    required this.web,
    required this.mobile,
  });
  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      web: json['web'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }
}

class UserTrainingLevel {
  final String id;
  final String name;

  UserTrainingLevel({
    required this.id,
    required this.name,
  });
  factory UserTrainingLevel.fromJson(Map<String, dynamic> json) {
    return UserTrainingLevel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
