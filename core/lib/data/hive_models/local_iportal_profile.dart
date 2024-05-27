// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive/hive.dart';

import 'local_children.dart';
import 'local_training_level.dart';
import 'local_user_features.dart';

part 'local_iportal_profile.g.dart';

@HiveType(typeId: 3)
class LocalIPortalProfile {
  @HiveField(0)
  final String name;
  @HiveField(2)
  final String user_key;
  @HiveField(3)
  final int user_id;
  @HiveField(4)
  final int school_id;
  @HiveField(5)
  final int pupil_id;
  @HiveField(6)
  final int type;
  @HiveField(7)
  final String type_text;
  @HiveField(8)
  final int parent_id;
  @HiveField(9)
  final String parent_name;
  @HiveField(10)
  final String father_name;
  @HiveField(11)
  final String learn_year;
  @HiveField(12)
  final String class_name;
  @HiveField(13)
  final String school_name;
  @HiveField(14)
  final String school_logo;
  @HiveField(15)
  final String school_brand;
  @HiveField(16)
  final int semester;
  @HiveField(17)
  final List<LocalChildren> children;
  @HiveField(18)
  final LocalTrainingLevel cap_dao_tao;
  @HiveField(19)
  final List<FeatureModel>? features;
  @HiveField(20)
  final List<int>? pinnedAlbumIdList;
  @HiveField(21)
  final SchoolBrand? background;

  LocalIPortalProfile({
    required this.name,
    required this.user_key,
    required this.user_id,
    required this.school_id,
    required this.pupil_id,
    required this.type,
    required this.type_text,
    required this.parent_id,
    required this.parent_name,
    required this.father_name,
    required this.learn_year,
    required this.class_name,
    required this.school_name,
    required this.school_logo,
    required this.school_brand,
    required this.semester,
    required this.children,
    required this.cap_dao_tao,
    this.features,
    this.pinnedAlbumIdList,
    this.background,
  });

  LocalIPortalProfile copyWith({
    String? name,
    String? user_key,
    int? user_id,
    int? school_id,
    int? pupil_id,
    int? type,
    String? type_text,
    int? parent_id,
    String? parent_name,
    String? father_name,
    String? learn_year,
    String? class_name,
    String? school_name,
    String? school_logo,
    String? school_brand,
    int? semester,
    List<LocalChildren>? children,
    LocalTrainingLevel? cap_dao_tao,
    List<FeatureModel>? features,
    List<int>? pinnedAlbumIdList,
    SchoolBrand? background,
  }) {
    return LocalIPortalProfile(
      name: name ?? this.name,
      user_key: user_key ?? this.user_key,
      user_id: user_id ?? this.user_id,
      school_id: school_id ?? this.school_id,
      pupil_id: pupil_id ?? this.pupil_id,
      type: type ?? this.type,
      type_text: type_text ?? this.type_text,
      parent_id: parent_id ?? this.parent_id,
      parent_name: parent_name ?? this.parent_name,
      father_name: father_name ?? this.father_name,
      learn_year: learn_year ?? this.learn_year,
      class_name: class_name ?? this.class_name,
      school_name: school_name ?? this.school_name,
      school_logo: school_logo ?? this.school_logo,
      school_brand: school_brand ?? this.school_brand,
      semester: semester ?? this.semester,
      children: children ?? this.children,
      cap_dao_tao: cap_dao_tao ?? this.cap_dao_tao,
      features: features ?? this.features,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
      background: background ?? this.background,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'user_key': user_key,
      'user_id': user_id,
      'school_id': school_id,
      'pupil_id': pupil_id,
      'type': type,
      'type_text': type_text,
      'parent_id': parent_id,
      'parent_name': parent_name,
      'father_name': father_name,
      'learn_year': learn_year,
      'class_name': class_name,
      'school_name': school_name,
      'school_logo': school_logo,
      'school_brand': school_brand,
      'semester': semester,
      'children': children.map((x) => x.toMap()).toList(),
      'cap_dao_tao': cap_dao_tao.toMap(),
    };
  }

  factory LocalIPortalProfile.fromMap(Map<String, dynamic> map) {
    final childrenData = map['children'];

    final children = childrenData is List
        ? childrenData
            .map((e) => LocalChildren.fromMap(e as Map<String, dynamic>))
            .toList()
        : [LocalChildren.fromMap(childrenData as Map<String, dynamic>)];

    return LocalIPortalProfile(
      name: map['name'] as String,
      user_key: map['user_key'] as String,
      user_id: map['user_id'].toInt() as int,
      school_id: map['school_id'].toInt() as int,
      pupil_id: map['pupil_id'].toInt() as int,
      type: map['type'].toInt() as int,
      type_text: map['type_text'] as String,
      parent_id: map['parent_id'].toInt() as int,
      parent_name: map['parent_name'] as String,
      father_name: map['father_name'] as String,
      learn_year: map['learn_year'] as String,
      class_name: map['class_name'] as String,
      school_name: map['school_name'] as String,
      school_logo: map['school_logo'] as String,
      school_brand: map['school_brand'] as String,
      semester: map['semester'].toInt() as int,
      children: children,
      cap_dao_tao: LocalTrainingLevel.fromMap(
        map['cap_dao_tao'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalIPortalProfile.fromJson(String source) =>
      LocalIPortalProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocalProfile(name: $name, user_key: $user_key, user_id: $user_id, school_id: $school_id, pupil_id: $pupil_id, type: $type, type_text: $type_text, parent_id: $parent_id, parent_name: $parent_name, father_name: $father_name, learn_year: $learn_year, class_name: $class_name, school_name: $school_name, school_logo: $school_logo, school_brand: $school_brand, semester: $semester, children: $children, cap_dao_tao: $cap_dao_tao)';
  }
}
