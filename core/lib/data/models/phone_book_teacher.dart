class PhoneBookTeacher {
  final int teacherId;
  final String userId;
  final int schoolId;
  final String schoolName;
  final String fullName;
  final String userKey;
  final String mainSubject;
  final UrlImageTeacher urlImageTeacher;
  final String phone;

  const PhoneBookTeacher({
    required this.fullName,
    required this.mainSubject,
    required this.schoolId,
    required this.schoolName,
    required this.teacherId,
    required this.urlImageTeacher,
    required this.userId,
    required this.userKey,
    required this.phone,
  });

  factory PhoneBookTeacher.fromMap(Map<String, dynamic> map) {
    final urlImage = UrlImageTeacher.fromMap(map['url_image']);
    return PhoneBookTeacher(
      fullName: map['full_name'] ?? '',
      mainSubject: map['main_subject'] ?? '',
      schoolId: map['school_id'] ?? 0,
      schoolName: map['school_name'] ?? '',
      teacherId: map['teacher_id'] ?? 0,
      urlImageTeacher: urlImage,
      userId: map['user_id'] ?? '',
      userKey: map['user_key'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  factory PhoneBookTeacher.fromJson(Map<String, dynamic> json) {
    final urlImage = UrlImageTeacher.fromJson(json['url_image']);
    return PhoneBookTeacher(
      fullName: json['full_name'] ?? '',
      mainSubject: json['main_subject'] ?? '',
      schoolId: json['school_id'] ?? 0,
      schoolName: json['school_name'] ?? '',
      teacherId: json['teacher_id'] ?? 0,
      urlImageTeacher: urlImage,
      userId: json['user_id'] ?? '',
      userKey: json['user_key'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
  factory PhoneBookTeacher.empty() => const PhoneBookTeacher(
        fullName: '',
        schoolId: 0,
        schoolName: '',
        urlImageTeacher: UrlImageTeacher(mobile: '', web: ''),
        userId: '',
        userKey: '',
        mainSubject: '',
        teacherId: 0,
        phone: '',
      );

  @override
  String toString() {
    return 'PhoneBookTeacher{teacherId: $teacherId, userId: $userId, schoolId: $schoolId, schoolName: $schoolName, fullName: $fullName, userKey: $userKey, mainSubject: $mainSubject, urlImageTeacher: $urlImageTeacher, phone: $phone}';
  }
}

class UrlImageTeacher {
  final String web;
  final String mobile;
  const UrlImageTeacher({required this.mobile, required this.web});
  factory UrlImageTeacher.fromJson(Map<String, dynamic> json) {
    return UrlImageTeacher(
        mobile: json['mobile'] as String, web: json['web'] as String);
  }

  factory UrlImageTeacher.fromMap(Map<String, dynamic> map) {
    return UrlImageTeacher(
      mobile: map['mobile'] as String,
      web: map['web'] as String,
    );
  }

  factory UrlImageTeacher.empty() => const UrlImageTeacher(mobile: '', web: '');
}
