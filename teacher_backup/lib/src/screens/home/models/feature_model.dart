import 'package:teacher/resources/assets.gen.dart';
import 'package:teacher/resources/i18n/locale_keys.g.dart';

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
    highSIcon: Assets.icons.features.highSInstructionNotebook.path,
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    id: 2,
    pinnedDefault: true,
    name: 'assignment book',
    highSIcon: Assets.icons.features.highSRegisterNotebook.path,
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    id: 14,
    name: 'attendance',
    highSIcon: Assets.icons.features.highSAttendance.path,
    category: FeatureCategory.daily,
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.green,
  ),
  FeatureModel(
    id: 3,
    pinnedDefault: true,
    name: 'school bus',
    highSIcon: Assets.icons.features.highSBus.path,
    preSIcon: Assets.icons.features.preSBus.path,
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    id: 4,
    name: 'menu',
    pinnedDefault: true,
    highSIcon: Assets.icons.features.menu.path,
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.yellow,
  ),

  FeatureModel(
    id: 5,
    pinnedDefault: true,
    name: LocaleKeys.leaveOfAbsence,
    highSIcon: Assets.icons.features.highSAlarm.path,
    preSIcon: Assets.icons.features.preSCalendar.path,
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.yellow,
  ),

  FeatureModel(
    id: 6,
    pinnedDefault: true,
    highSIcon: Assets.icons.features.highSMessage.path,
    preSIcon: Assets.icons.features.preSMessage.path,
    name: 'comments',
    gradientType: FeatureGradient.green,
    category: FeatureCategory.daily,
  ),

  // STUDY INFO
  FeatureModel(
    id: 13,
    highSIcon: Assets.icons.features.highSScores.path,
    name: 'check grades',
    gradeLevel: FeatureGradeLevel.highschool,
    gradientType: FeatureGradient.yellow,
    category: FeatureCategory.studyInfo,
  ),

  // Services
  FeatureModel(
    id: 8,
    highSIcon: Assets.icons.features.highSTuition.path,
    preSIcon: Assets.icons.features.preSTuition.path,
    name: 'tuition fee',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.orange,
  ),
  FeatureModel(
    id: 9,
    highSIcon: Assets.icons.features.highSPhoneBook.path,
    preSIcon: Assets.icons.features.preSPhoneBook.path,
    name: 'contact list',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.lightblue,
  ),
  FeatureModel(
    id: 10,
    highSIcon: Assets.icons.features.highSDollar.path,
    preSIcon: Assets.icons.features.preSTariff.path,
    name: 'fee schedule',
    category: FeatureCategory.services,
    gradientType: FeatureGradient.green,
  ),

  // Other
  FeatureModel(
    id: 7,
    pinnedDefault: true,
    highSIcon: Assets.icons.features.health.path,
    preSIcon: Assets.icons.features.preSHeartplus.path,
    name: 'health',
    category: FeatureCategory.daily,
    gradientType: FeatureGradient.darkblue,
  ),
  FeatureModel(
    id: 12,
    highSIcon: Assets.icons.features.highSGallery.path,
    preSIcon: Assets.icons.features.preSGallery.path,
    name: 'photo library',
    category: FeatureCategory.other,
    gradientType: FeatureGradient.yellow,
  ),
  FeatureModel(
    id: 13,
    highSIcon: Assets.icons.features.highSMessage.path,
    preSIcon: Assets.icons.features.preSSurvey.path,
    name: 'survey',
    category: FeatureCategory.other,
    gradientType: FeatureGradient.green,
  ),
];
