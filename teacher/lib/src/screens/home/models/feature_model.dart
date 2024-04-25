import 'package:teacher/resources/assets.gen.dart';

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
    name: 'lesson plan book',
    highSIcon: Assets.icons.features.highSInstructionNotebook,
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    id: 2,
    pinnedDefault: true,
    name: 'assignment book',
    highSIcon: Assets.icons.features.highSRegisterNotebook,
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    id: 14,
    name: 'attendance',
    highSIcon: Assets.icons.features.highSAttendance,
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.green,
  ),
  FeatureModel(
    id: 3,
    pinnedDefault: true,
    name: 'school bus',
    highSIcon: Assets.icons.features.highSBus,
    preSIcon: Assets.icons.features.preSBus,
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    id: 4,
    name: 'menu',
    pinnedDefault: true,
    highSIcon: Assets.icons.features.menu,
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.yellow,
  ),

  FeatureModel(
    id: 5,
    pinnedDefault: true,
    name: 'leave of absence',
    highSIcon: Assets.icons.features.highSAlarm,
    preSIcon: Assets.icons.features.preSCalendar,
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.yellow,
  ),

  FeatureModel(
    id: 6,
    pinnedDefault: true,
    highSIcon: Assets.icons.features.highSMessage,
    preSIcon: Assets.icons.features.preSMessage,
    name: 'comments',
    gradientType: FeatureGradient.green,
    category: FeatureCategory.daily,
  ),

  // STUDY INFO
  FeatureModel(
    id: 13,
    highSIcon: Assets.icons.features.highSScores,
    name: 'check grades',
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.yellow,
    category: FeatureCategory.studyInfo,
  ),

  // Services
  FeatureModel(
    id: 8,
    highSIcon: Assets.icons.features.highSTuition,
    preSIcon: Assets.icons.features.preSTuition,
    name: 'tuition fee',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    id: 9,
    highSIcon: Assets.icons.features.highSPhoneBook,
    preSIcon: Assets.icons.features.preSPhoneBook,
    name: 'contact list',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    id: 10,
    highSIcon: Assets.icons.features.highSDollar,
    preSIcon: Assets.icons.features.preSTariff,
    name: 'fee schedule',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.green,
  ),

  // Other
  FeatureModel(
    id: 7,
    pinnedDefault: true,
    highSIcon: Assets.icons.features.health,
    preSIcon: Assets.icons.features.preSHeartplus,
    name: 'health',
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    id: 12,
    highSIcon: Assets.icons.features.highSGallery,
    preSIcon: Assets.icons.features.preSGallery,
    name: 'photo library',
    category: FeatureCategory.other,
    gradientType: FeatureGradient.yellow,
  ),
  FeatureModel(
    id: 13,
    highSIcon: Assets.icons.features.highSMessage,
    preSIcon: Assets.icons.features.preSSurvey,
    name: 'survey',
    category: FeatureCategory.other,
    gradientType: FeatureGradient.green,
  ),
];
