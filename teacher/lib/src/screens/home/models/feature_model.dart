enum FeatureCategory { daily, studyInfo, services, other, all }

enum FeatureGradient { darkblue, lightblue, orange, green, yellow, gray }

enum FeatureGradeLevel { highschool, preschool, both }

class FeatureModel {
  final int id;
  final FeatureGradeLevel gradeLevel;
  final String? highSIcon;
  final String? preSIcon;
  final String name;
  final bool pinnedDefault;
  final bool hasPinned;
  final FeatureCategory category;
  final FeatureGradient? gradientType;

  FeatureModel({
    required this.id,
    this.gradeLevel = FeatureGradeLevel.both,
    this.highSIcon,
    this.preSIcon,
    this.pinnedDefault = false,
    this.hasPinned = false,
    required this.category,
    required this.name,
    this.gradientType,
  });

  FeatureModel copyWith({
    int? ind,
    FeatureGradient? gradientType,
    String? highSIcon,
    String? preSIcon,
    String? name,
    FeatureCategory? category,
    bool? hasPinned,
  }) {
    return FeatureModel(
      id: id,
      hasPinned: hasPinned ?? this.hasPinned,
      gradientType: gradientType ?? this.gradientType,
      highSIcon: highSIcon ?? this.highSIcon,
      preSIcon: preSIcon ?? this.preSIcon,
      name: name ?? this.name,
      category: category ?? this.category,
      gradeLevel: gradeLevel,
    );
  }

  factory FeatureModel.empty() => FeatureModel(
        id: -1,
        category: FeatureCategory.other,
        highSIcon: '',
        preSIcon: '',
        gradientType: FeatureGradient.darkblue,
        name: '',
      );
}

final List<FeatureModel> features = [
  // Daily Activity
  FeatureModel(
    id: 1,
    pinnedDefault: true,
    name: 'Sổ đầu bài',
    highSIcon: 'highS_register-notebook',
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    id: 2,
    name: 'Điểm danh',
    highSIcon: 'highS_attendance',
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.green,
  ),
  FeatureModel(
    id: 3,
    pinnedDefault: true,
    name: 'Xe đưa rước',
    highSIcon: 'highS_bus',
    preSIcon: 'preS_bus',
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    id: 4,
    pinnedDefault: true,
    name: 'Sổ báo bài',
    highSIcon: 'highS_instruction-notebook',
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    id: 5,
    pinnedDefault: true,
    name: 'Nghỉ phép',
    highSIcon: 'highS_alarm',
    preSIcon: 'preS_calendar',
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.yellow,
  ),

  // STUDY INFO
  FeatureModel(
    id: 6,
    pinnedDefault: true,
    highSIcon: 'highS_scores',
    name: 'Xem điểm',
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.yellow,
    category: FeatureCategory.studyInfo,
  ),

  FeatureModel(
    id: 7,
    pinnedDefault: true,
    preSIcon: 'preS_message',
    name: 'Nhận xét',
    gradeLevel: FeatureGradeLevel.preschool,
    category: FeatureCategory.studyInfo,
  ),

  // Services
  FeatureModel(
    id: 8,
    pinnedDefault: true,
    highSIcon: 'highS_tuition',
    preSIcon: 'preS_tuition',
    name: 'Học phí',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    id: 9,
    pinnedDefault: true,
    highSIcon: 'highS_phone-book',
    preSIcon: 'preS_phone-book',
    name: 'Danh bạ',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    id: 10,
    highSIcon: 'highS_dollar',
    preSIcon: 'preS_tariff',
    name: 'Biểu phí',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.green,
  ),

  // Other
  FeatureModel(
    id: 11,
    pinnedDefault: true,
    preSIcon: 'preS_heartplus',
    name: 'Sức khỏe',
    category: FeatureCategory.other,
    gradeLevel: FeatureGradeLevel.preschool,
  ),
  FeatureModel(
    id: 12,
    highSIcon: 'highS_gallery',
    preSIcon: 'preS_gallery',
    name: 'Thư viện ảnh',
    category: FeatureCategory.other,
    gradientType: FeatureGradient.yellow,
  ),
  FeatureModel(
    id: 13,
    highSIcon: 'highS_message',
    preSIcon: 'preS_survey',
    name: 'Khảo sát',
    category: FeatureCategory.other,
    gradientType: FeatureGradient.green,
  ),
];
