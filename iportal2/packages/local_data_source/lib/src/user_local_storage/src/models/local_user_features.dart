
import 'package:hive_flutter/hive_flutter.dart';

part 'local_user_features.g.dart';

@HiveType(typeId: 9)
enum FeatureCategory {
  @HiveField(0)
  daily,

  @HiveField(1)
  studyInfo,

  @HiveField(2)
  services,

  @HiveField(3)
  other,

  @HiveField(4)
  all
}

@HiveType(typeId: 10)
enum FeatureGradient {
  @HiveField(0)
  darkblue,

  @HiveField(1)
  lightblue,

  @HiveField(2)
  orange,

  @HiveField(3)
  green,

  @HiveField(4)
  yellow,

  @HiveField(5)
  gray
}

@HiveType(typeId: 8)
enum FeatureKey {
  // Only High School
  @HiveField(0)
  instructionNotebook, // Sổ báo bài

  @HiveField(1)
  registerNotebook, // Sổ đầu bài

  @HiveField(2)
  bus, // Xe đưa rước

  @HiveField(3)
  scores, // Xem điểm

  // Both Preschool and High School
  @HiveField(4)
  onLeave, // Nghỉ phép

  @HiveField(5)
  menu, // Thực đơn

  @HiveField(6)
  tuition, // Học phí

  @HiveField(7)
  phoneBook, // Danh bạ

  @HiveField(8)
  tariff, // Biểu phí

  @HiveField(9)
  survey, // Khảo sát

  @HiveField(10)
  gallery, // Thư viện ảnh

  // Only Preschool
  @HiveField(11)
  comment, // Nhận xét

  @HiveField(12)
  attendance, // Điểm danh

  @HiveField(13)
  health, // Sức khỏe

  @HiveField(14)
  all, // Tất cả
}

extension StatusX on FeatureKey {
  String get valueAsString => toString().split('.').last;

  // Or as a function
  String asString() => toString().split('.').last;
}

@HiveType(typeId: 7)
class FeatureModel {
  @HiveField(0)
  final FeatureKey key;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  @HiveField(3)
  final FeatureCategory category;

  @HiveField(4)
  final bool pinned;

  @HiveField(5)
  final int order;

  @HiveField(7)
  final FeatureGradient? gradientType;

  FeatureModel({
    required this.key,
    required this.name,
    required this.icon,
    required this.category,
    this.gradientType,
    this.order = 0,
    this.pinned = true,
  });

  FeatureModel copyWith({
    bool? pinned,
    int? order,
  }) {
    return FeatureModel(
      key: key,
      name: name,
      icon: icon,
      category: category,
      gradientType: gradientType,
      order: order ?? this.order,
      pinned: pinned ?? this.pinned,
    );
  }

  factory FeatureModel.empty() => FeatureModel(
      key: FeatureKey.all, name: '', icon: '', category: FeatureCategory.all);

  static fromMap(Map<String, dynamic> e) {}

  Map<String, dynamic> toMap() {
    return {
      'key': key.valueAsString,
      'name': name,
      'icon': icon,
      'category': category.index,
      'pinned': pinned,
      'order': order,
      'gradientType': gradientType?.index,
    };
  }
}

final List<FeatureModel> preSFeatures = [
  // Hoạt động hằng ngày
  FeatureModel(
    key: FeatureKey.onLeave,
    name: 'Nghỉ phép',
    icon: 'preS_calendar',
    category: FeatureCategory.daily,
    order: 2,
  ),
  FeatureModel(
    key: FeatureKey.menu,
    name: 'Thực đơn',
    icon: 'preS_menu',
    category: FeatureCategory.daily,
    order: 1,
  ),
  FeatureModel(
    key: FeatureKey.bus,
    name: 'Xe đưa rước',
    icon: 'preS_bus',
    category: FeatureCategory.daily,
    pinned: false,
  ),

  // Thông tin học tập
  FeatureModel(
    key: FeatureKey.comment,
    name: 'Nhận xét',
    icon: 'preS_comment',
    category: FeatureCategory.studyInfo,
    order: 3,
  ),

  // Dịch vụ học đường
  FeatureModel(
    key: FeatureKey.tuition,
    name: 'Học phí',
    icon: 'preS_tuition',
    category: FeatureCategory.services,
    order: 6,
  ),
  FeatureModel(
    key: FeatureKey.phoneBook,
    name: 'Danh bạ',
    icon: 'preS_phone-book',
    category: FeatureCategory.services,
    order: 7,
  ),
  FeatureModel(
    key: FeatureKey.tariff,
    name: 'Biểu phí',
    icon: 'preS_tariff',
    category: FeatureCategory.services,
    pinned: false,
  ),

  // Thông tin khác
  FeatureModel(
    key: FeatureKey.health,
    name: 'Sức khỏe',
    icon: 'preS_health',
    category: FeatureCategory.other,
    pinned: false,
  ),
  FeatureModel(
    key: FeatureKey.survey,
    name: 'Khảo sát',
    icon: 'preS_survey',
    category: FeatureCategory.other,
    order: 4,
  ),
  FeatureModel(
    key: FeatureKey.gallery,
    name: 'Thư viện ảnh',
    icon: 'preS_gallery',
    category: FeatureCategory.other,
    // defaultPinned: false,
    order: 5,
  ),
];

final List<FeatureModel> hihgSFeatures = [
  // Hoạt động hằng ngày
  FeatureModel(
    key: FeatureKey.registerNotebook,
    name: 'Sổ đầu bài',
    icon: 'highS_register-notebook',
    category: FeatureCategory.daily,
    order: 1,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    key: FeatureKey.instructionNotebook,
    name: 'Sổ báo bài',
    icon: 'highS_instruction-notebook',
    category: FeatureCategory.daily,
    order: 2,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    key: FeatureKey.bus,
    name: 'Xe đưa rước',
    icon: 'highS_bus',
    category: FeatureCategory.daily,
    order: 3,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    key: FeatureKey.menu,
    name: 'Thực đơn',
    icon: 'highS_menu',
    category: FeatureCategory.daily,
    pinned: false,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    key: FeatureKey.onLeave,
    name: 'Nghỉ phép',
    icon: 'highS_attendance',
    category: FeatureCategory.daily,
    order: 5,
    gradientType: FeatureGradient.yellow,
  ),

  // Thông tin học tập
  FeatureModel(
    key: FeatureKey.scores,
    name: 'Xem điểm',
    icon: 'highS_scores',
    category: FeatureCategory.studyInfo,
    pinned: false,
    gradientType: FeatureGradient.lightblue,
  ),

  // Dịch vụ học đường
  FeatureModel(
    key: FeatureKey.tuition,
    name: 'Học phí',
    icon: 'highS_tuition',
    category: FeatureCategory.services,
    order: 6,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    key: FeatureKey.phoneBook,
    name: 'Danh bạ',
    icon: 'highS_phone-book',
    category: FeatureCategory.services,
    order: 7,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    key: FeatureKey.tariff,
    name: 'Biểu phí',
    icon: 'highS_tariff',
    category: FeatureCategory.services,
    pinned: false,
    gradientType: FeatureGradient.green,
  ),

  // Thông tin khác
  FeatureModel(
    key: FeatureKey.gallery,
    name: 'Thư viện ảnh',
    icon: 'highS_gallery',
    category: FeatureCategory.other,
    pinned: false,
    gradientType: FeatureGradient.yellow,
  ),
  FeatureModel(
    key: FeatureKey.survey,
    name: 'Khảo sát',
    icon: 'highS_survey',
    category: FeatureCategory.other,
    order: 4,
    gradientType: FeatureGradient.green,
  ),
];
