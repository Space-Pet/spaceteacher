import 'dart:convert';

import 'package:hive/hive.dart';

import '../models/models.dart';
import 'local_training_level.dart';
import 'local_url_image.dart';
import 'local_user_features.dart';

part 'local_children.g.dart';

@HiveType(typeId: 4)
class LocalChildren {
  @HiveField(0)
  final int pupil_id;
  @HiveField(1)
  final String user_id;
  @HiveField(2)
  final int school_id;
  @HiveField(3)
  final String school_name;
  @HiveField(4)
  final int class_id;
  @HiveField(5)
  final int customer_id;
  @HiveField(6)
  final String full_name;
  @HiveField(7)
  final String user_key;
  @HiveField(8)
  final int parent_id;
  @HiveField(9)
  final String class_name;
  @HiveField(10)
  final bool isActive;
  @HiveField(11)
  final LocalTrainingLevel cap_dao_tao;
  @HiveField(12)
  final List<FeatureModel> features;
  @HiveField(13)
  final List<int> pinnedAlbumIdList;
  @HiveField(14)
  final SchoolBrand background;
  @HiveField(15)
  final bool isMN;
  @HiveField(16)
  final String school_brand;
  @HiveField(17)
  final LocalUrlImage url_image;
  @HiveField(18)
  final String? learn_year;
  @HiveField(19)
  final LearnYear? learnYearList;

  LocalChildren({
    required this.pupil_id,
    required this.user_id,
    required this.school_id,
    required this.school_name,
    required this.class_id,
    required this.customer_id,
    required this.full_name,
    required this.user_key,
    required this.parent_id,
    required this.class_name,
    required this.isActive,
    required this.cap_dao_tao,
    required this.features,
    required this.pinnedAlbumIdList,
    required this.background,
    this.isMN = false,
    this.school_brand = 'uka',
    required this.url_image,
    this.learn_year,
    this.learnYearList,
  });

  LocalChildren copyWith({
    int? pupil_id,
    String? user_id,
    int? school_id,
    String? school_name,
    int? class_id,
    int? customer_id,
    String? full_name,
    String? user_key,
    int? parent_id,
    String? class_name,
    bool? isActive,
    LocalTrainingLevel? cap_dao_tao,
    List<FeatureModel>? features,
    List<int>? pinnedAlbumIdList,
    SchoolBrand? background,
    bool? isMN,
    String? school_brand,
    LocalUrlImage? url_image,
    String? learn_year,
    LearnYear? learnYearList,
  }) {
    return LocalChildren(
      pupil_id: pupil_id ?? this.pupil_id,
      user_id: user_id ?? this.user_id,
      school_id: school_id ?? this.school_id,
      school_name: school_name ?? this.school_name,
      class_id: class_id ?? this.class_id,
      customer_id: customer_id ?? this.customer_id,
      full_name: full_name ?? this.full_name,
      user_key: user_key ?? this.user_key,
      parent_id: parent_id ?? this.parent_id,
      class_name: class_name ?? this.class_name,
      isActive: isActive ?? this.isActive,
      cap_dao_tao: cap_dao_tao ?? this.cap_dao_tao,
      features: features ?? this.features,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
      background: background ?? this.background,
      isMN: isMN ?? this.isMN,
      school_brand: school_brand ?? this.school_brand,
      url_image: url_image ?? this.url_image,
      learn_year: learn_year ?? this.learn_year,
      learnYearList: learnYearList ?? this.learnYearList,
    );
  }

  // Mầm non:
  // 'C_001', Nhà trẻ'
  // 'C_002', Mẫu giáo
  // Phổ thông
  // 'C_003', Tiểu học
  // 'C_004', Trung học cơ sở
  // 'C_005', 'Trung học phổ thông

  bool isMamNon() {
    return ['C_001', 'C_002'].contains(cap_dao_tao.id);
  }

  bool isPrimary() {
    return cap_dao_tao.id == 'C_003';
  }

  bool isHighSchool() {
    return ['C_004', 'C_005'].contains(cap_dao_tao.id);
  }

  factory LocalChildren.fromMap(Map<String, dynamic> map) {
    return LocalChildren(
      pupil_id: map['pupil_id'].toInt() as int,
      user_id: map['user_id'] as String,
      school_id: map['school_id'].toInt() as int,
      school_name: map['school_name'] as String,
      class_id: map['class_id'].toInt() as int,
      customer_id: map['customer_id'].toInt() as int,
      full_name: map['full_name'] as String,
      user_key: map['user_key'] as String,
      parent_id: map['parent_id'].toInt() as int,
      class_name: map['class_name'] as String,
      isActive: map['isActive'] as bool,
      cap_dao_tao: LocalTrainingLevel.fromMap(
        map['cap_dao_tao'] as Map<String, dynamic>,
      ),
      features: List<FeatureModel>.from(
        map['features'] as List<dynamic>,
      ),
      pinnedAlbumIdList: List<int>.from(
        map['pinnedAlbumIdList'] as List<dynamic>,
      ),
      background: SchoolBrand.values.firstWhere(
        (element) => element.value == map['background'] as String,
      ),
      isMN: map['isMN'] as bool,
      school_brand: map['school_brand'] as String,
      url_image: LocalUrlImage.fromMap(
        map['url_image'] as Map<String, dynamic>,
      ),
      learn_year: map['learn_year'] as String?,
      learnYearList: LearnYear.fromMap(
        map['learnYearList'] as Map<String, dynamic>,
      ),
    );
  }

  factory LocalChildren.fromJson(String source) =>
      LocalChildren.fromMap(json.decode(source) as Map<String, dynamic>);

  factory LocalChildren.empty() {
    return LocalChildren(
      pupil_id: 0,
      user_id: '',
      school_id: 0,
      school_name: '',
      class_id: 0,
      customer_id: 0,
      full_name: '',
      user_key: '',
      parent_id: 0,
      class_name: '',
      isActive: false,
      cap_dao_tao: LocalTrainingLevel(id: '', name: ''),
      features: [],
      pinnedAlbumIdList: [],
      background: SchoolBrand.values.first,
      isMN: false,
      school_brand: 'uka',
      url_image: LocalUrlImage(web: '', mobile: ''),
      learn_year: '',
      learnYearList: LearnYear.empty(),
    );
  }
}
