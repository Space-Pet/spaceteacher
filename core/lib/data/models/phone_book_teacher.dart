class PhoneBookTeacher {
  final int teacherId;
  final String userId;
  final int schoolId;
  final String schoolName;
  final String fullName;
  final String userKey;
  final String mainSubject;
  final UrlImageTeacher urlImageTeacher;
  const PhoneBookTeacher({
    required this.fullName,
    required this.mainSubject,
    required this.schoolId,
    required this.schoolName,
    required this.teacherId,
    required this.urlImageTeacher,
    required this.userId,
    required this.userKey,
  });
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
        userKey: json['user_key'] ?? '');
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
      );
}

class UrlImageTeacher {
  final String web;
  final String mobile;
  const UrlImageTeacher({required this.mobile, required this.web});
  factory UrlImageTeacher.fromJson(Map<String, dynamic> json) {
    return UrlImageTeacher(
        mobile: json['mobile'] as String, web: json['web'] as String);
  }
}
