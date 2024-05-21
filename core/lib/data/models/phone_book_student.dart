class PhoneBookStudent {
  final int pupilId;
  final String userId;
  final int classId;
  final String fullName;
  final String userKey;
  final String className;
  final UrlImagePhoneBook urlImage;
  const PhoneBookStudent(
      {required this.classId,
      required this.fullName,
      required this.pupilId,
      required this.className,
      required this.urlImage,
      required this.userId,
      required this.userKey});
  factory PhoneBookStudent.fromJson(Map<String, dynamic> json) {
    final urlImage = UrlImagePhoneBook.fromJson(json['url_image']);
    return PhoneBookStudent(
        classId: json['class_id'] ?? 0,
        fullName: json['full_name'] ?? '',
        pupilId: json['pupil_id'] ?? 0,
        className: json['class_name'] ?? '',
        urlImage: urlImage,
        userId: json['user_id'] ?? '',
        userKey: json['user_key'] ?? '');
  }
  factory PhoneBookStudent.empty() => const PhoneBookStudent(
        classId: 0,
        fullName: '',
        className: '',
        pupilId: 0,
        urlImage: UrlImagePhoneBook(mobile: '', web: ''),
        userId: '',
        userKey: '',
      );
}

class UrlImagePhoneBook {
  final String web;
  final String mobile;
  const UrlImagePhoneBook({required this.mobile, required this.web});
  factory UrlImagePhoneBook.fromJson(Map<String, dynamic> json) {
    return UrlImagePhoneBook(
        mobile: json['mobile'] as String, web: json['web'] as String);
  }
}
