import 'dart:convert';

class TeacherDetail {
  TeacherInfo info;
  LopChuNhiem lopChuNhiem;
  int pushNotify;

  TeacherDetail({
    required this.info,
    required this.lopChuNhiem,
    required this.pushNotify,
  });

  factory TeacherDetail.empty() {
    return TeacherDetail(
      info: TeacherInfo.empty(),
      lopChuNhiem: LopChuNhiem(
        id: 0,
        name: '',
      ),
      pushNotify: 0,
    );
  }

  factory TeacherDetail.fromMap(Map<String, dynamic> map) {
    return TeacherDetail(
      info: TeacherInfo.fromMap(map['info']),
      lopChuNhiem: LopChuNhiem.fromMap(map['lop_chu_nhiem']),
      pushNotify: map['push_notify'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'info': info.toMap(),
      'lop_chu_nhiem': lopChuNhiem.toMap(),
      'push_notify': pushNotify,
    };
  }

  factory TeacherDetail.fromJson(String json) {
    return TeacherDetail.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class TeacherInfo {
  int teacherId;
  String userId;
  String birthday;
  int schoolId;
  String schoolName;
  String fullName;
  String userKey;
  String positionName;
  String mainSubject;
  int subjectId;
  UrlImage urlImage;
  String address;
  String phone;
  CapDaoTao capDaoTao;

  TeacherInfo({
    required this.teacherId,
    required this.userId,
    required this.birthday,
    required this.schoolId,
    required this.schoolName,
    required this.fullName,
    required this.userKey,
    required this.positionName,
    required this.mainSubject,
    required this.subjectId,
    required this.urlImage,
    required this.address,
    required this.phone,
    required this.capDaoTao,
  });

  factory TeacherInfo.fromMap(Map<String, dynamic> map) {
    return TeacherInfo(
      teacherId: map['teacher_id'],
      userId: map['user_id'],
      birthday: map['birthday'],
      schoolId: map['school_id'],
      schoolName: map['school_name'],
      fullName: map['full_name'],
      userKey: map['user_key'],
      positionName: map['position_name'],
      mainSubject: map['main_subject'],
      subjectId: map['subject_id'],
      urlImage: UrlImage.fromMap(map['url_image']),
      address: map['address'],
      phone: map['phone'],
      capDaoTao: CapDaoTao.fromMap(map['cap_dao_tao']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacher_id': teacherId,
      'user_id': userId,
      'birthday': birthday,
      'school_id': schoolId,
      'school_name': schoolName,
      'full_name': fullName,
      'user_key': userKey,
      'position_name': positionName,
      'main_subject': mainSubject,
      'subject_id': subjectId,
      'url_image': urlImage.toMap(),
      'address': address,
      'phone': phone,
      'cap_dao_tao': capDaoTao.toMap(),
    };
  }

  factory TeacherInfo.fromJson(String json) {
    return TeacherInfo.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory TeacherInfo.empty() {
    return TeacherInfo(
      teacherId: 0,
      userId: '',
      birthday: '',
      schoolId: 0,
      schoolName: '',
      fullName: '',
      userKey: '',
      positionName: '',
      mainSubject: '',
      subjectId: 0,
      urlImage: UrlImage(
        web: '',
        mobile: '',
      ),
      address: '',
      phone: '',
      capDaoTao: CapDaoTao(
        id: '',
        name: '',
      ),
    );
  }
}

class UrlImage {
  final String web;
  final String mobile;

  UrlImage({
    required this.web,
    required this.mobile,
  });

  factory UrlImage.fromMap(Map<String, dynamic> map) {
    return UrlImage(
      web: map['web'],
      mobile: map['mobile'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'web': web,
      'mobile': mobile,
    };
  }
}

class CapDaoTao {
  final String id;
  final String name;

  CapDaoTao({
    required this.id,
    required this.name,
  });

  factory CapDaoTao.fromMap(Map<String, dynamic> map) {
    return CapDaoTao(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class LopChuNhiem {
  final int id;
  final String name;

  LopChuNhiem({
    required this.id,
    required this.name,
  });

  factory LopChuNhiem.fromMap(Map<String, dynamic> map) {
    final id = map['id'] is int ? map['id'] : 0;
    return LopChuNhiem(
      id: id,
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
