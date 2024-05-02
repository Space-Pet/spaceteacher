import 'package:local_data_source/local_data_source.dart';

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
