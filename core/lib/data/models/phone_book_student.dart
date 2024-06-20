class PhoneBookStudent {
  final int pupilId;
  final int userId;
  final int classId;
  final String fullName;
  final String userKey;
  final String className;
  final UrlImagePhoneBook urlImage;
  final String schoolName;
  final int customerId;
  final int parentId;
  final String email;
  final bool selected;

  const PhoneBookStudent({
    required this.classId,
    required this.fullName,
    required this.schoolName,
    required this.pupilId,
    required this.className,
    required this.urlImage,
    required this.userId,
    required this.userKey,
    required this.customerId,
    required this.parentId,
    required this.email,
    required this.selected,
  });

  factory PhoneBookStudent.fromJson(Map<String, dynamic> json) {
    final urlImage = UrlImagePhoneBook.fromJson(json['url_image']);
    return PhoneBookStudent(
      schoolName: json['school_name'] ?? '',
      classId: json['class_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      pupilId: json['pupil_id'] ?? 0,
      className: json['class_name'] ?? '',
      urlImage: urlImage,
      userId: int.parse(json['user_id'] ?? ''),
      userKey: json['user_key'] ?? '',
      customerId: json['customer_id'] ?? 0,
      parentId: json['parent_id'] ?? 0,
      email: json['email'] ?? '',
      selected: json['selected'] ?? false,
    );
  }

  factory PhoneBookStudent.empty() => const PhoneBookStudent(
        schoolName: '',
        classId: 0,
        fullName: '',
        className: '',
        pupilId: 0,
        urlImage: UrlImagePhoneBook(mobile: '', web: ''),
        userId: 0,
        userKey: '',
        customerId: 0,
        parentId: 0,
        email: '',
        selected: false,
      );

  static List<PhoneBookStudent> fakeData() {
    return List.generate(
        10,
        (index) => PhoneBookStudent(
              schoolName: 'schoolName $index',
              classId: index,
              fullName: 'fullName $index',
              pupilId: index,
              className: 'className $index',
              urlImage: const UrlImagePhoneBook(mobile: '', web: ''),
              userId: index,
              userKey: 'userKey $index',
              customerId: index,
              parentId: index,
              email: 'email $index',
              selected: false,
            ));
  }
}

class UrlImagePhoneBook {
  final String web;
  final String mobile;

  const UrlImagePhoneBook({required this.mobile, required this.web});

  factory UrlImagePhoneBook.fromJson(Map<String, dynamic> json) {
    return UrlImagePhoneBook(
      mobile: json['mobile'] as String,
      web: json['web'] as String,
    );
  }
}
