class PupilInClass {
  final int pupilId;
  final String userId;
  final int classId;
  final int customerId;
  final String fullName;
  final String userKey;
  final int parentId;
  final String className;
  // final Map<String, String> urlImage;
  final String email;
  final dynamic selected;

  PupilInClass({
    required this.pupilId,
    required this.userId,
    required this.classId,
    required this.customerId,
    required this.fullName,
    required this.userKey,
    required this.parentId,
    required this.className,
    // required this.urlImage,
    required this.email,
    required this.selected,
  });

  factory PupilInClass.fromJson(Map<String, dynamic> json) {
    return PupilInClass(
      pupilId: json['pupil_id'],
      userId: json['user_id'],
      classId: json['class_id'],
      customerId: json['customer_id'],
      fullName: json['full_name'],
      userKey: json['user_key'],
      parentId: json['parent_id'],
      className: json['class_name'],
      // urlImage: Map<String, String>.from(json['url_image']),
      email: json['email'],
      selected: json['selected'],
    );
  }

  factory PupilInClass.empty() {
    return PupilInClass(
      pupilId: 0,
      userId: '',
      classId: 0,
      customerId: 0,
      fullName: 'Tất cả',
      userKey: '',
      parentId: 0,
      className: '',
      // urlImage: {},
      email: '',
      selected: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pupil_id': pupilId,
      'user_id': userId,
      'class_id': classId,
      'customer_id': customerId,
      'full_name': fullName,
      'user_key': userKey,
      'parent_id': parentId,
      'class_name': className,
      // 'url_image': urlImage,
      'email': email,
      'selected': selected,
    };
  }
}
