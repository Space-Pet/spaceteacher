enum FeatureCategory { daily, studyInfo, services, other, all }

enum FeatureGradient { darkblue, lightblue, orange, green, yellow, gray }

enum FeatureKey {
  // Only High School
  instructionNotebook, // Sổ báo bài
  registerNotebook, // Sổ đầu bài
  bus, // Xe đưa rước
  scores, // Xem điểm

  // Both Preschool and High School
  onLeave, // Nghỉ phép
  menu, // Thực đơn
  tuition, // Học phí
  phoneBook, // Danh bạ
  tariff, // Biểu phí
  survey, // Khảo sát
  gallery, // Thư viện ảnh

  // Only Preschool
  comment, // Nhận xét
  attendance, // Điểm danh
  health, // Sức khỏe

  all, // Tất cả
}

class FeatureModel {
  final FeatureKey key;
  final String name;
  final String icon;
  final FeatureCategory category;
  final bool defaultPinned;
  final int defaultOrder;
  final bool hasPinned;
  final FeatureGradient? gradientType;

  FeatureModel({
    required this.key,
    required this.name,
    required this.icon,
    required this.category,
    this.defaultPinned = true,
    this.defaultOrder = 0,
    this.hasPinned = false,
    this.gradientType,
  });

  FeatureModel copyWith({
    bool? hasPinned,
  }) {
    return FeatureModel(
      key: key,
      name: name,
      icon: icon,
      category: category,
      defaultPinned: defaultPinned,
      defaultOrder: defaultOrder,
      hasPinned: hasPinned ?? this.hasPinned,
      gradientType: gradientType,
    );
  }

  factory FeatureModel.empty() => FeatureModel(
      key: FeatureKey.all, name: '', icon: '', category: FeatureCategory.all);
}
