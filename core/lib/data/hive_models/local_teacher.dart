// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '../../core.dart';

part 'local_teacher.g.dart';

@HiveType(typeId: 13)
class LocalTeacher {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int teacher_id;
  @HiveField(2)
  final String user_key;
  @HiveField(3)
  final int user_id;
  @HiveField(4)
  final int school_id;
  @HiveField(5)
  final String school_brand;
  @HiveField(6)
  final List<FeatureModel> features;
  @HiveField(7)
  final List<int> pinnedAlbumIdList;
  @HiveField(8)
  final SchoolBrand background;
  @HiveField(9)
  final bool isKinderGarten;

  LocalTeacher({
    required this.name,
    required this.teacher_id,
    required this.user_key,
    required this.user_id,
    required this.school_id,
    required this.school_brand,
    required this.features,
    required this.pinnedAlbumIdList,
    required this.background,
    required this.isKinderGarten,
  });

  LocalTeacher copyWith({
    String? name,
    int? teacher_id,
    String? user_key,
    int? user_id,
    int? school_id,
    String? school_brand,
    List<FeatureModel>? features,
    List<int>? pinnedAlbumIdList,
    SchoolBrand? background,
    bool? isKinderGarten,
  }) {
    return LocalTeacher(
      name: name ?? this.name,
      teacher_id: teacher_id ?? this.teacher_id,
      user_key: user_key ?? this.user_key,
      user_id: user_id ?? this.user_id,
      school_id: school_id ?? this.school_id,
      school_brand: school_brand ?? this.school_brand,
      features: features ?? this.features,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
      background: background ?? this.background,
      isKinderGarten: isKinderGarten ?? this.isKinderGarten,
    );
  }

  factory LocalTeacher.empty() {
    return LocalTeacher(
      name: '',
      teacher_id: 0,
      user_key: '',
      user_id: 0,
      school_id: 0,
      school_brand: '',
      features: [],
      pinnedAlbumIdList: [],
      background: SchoolBrand.uka,
      isKinderGarten: false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teacher_id': teacher_id,
      'user_key': user_key,
      'user_id': user_id,
      'school_id': school_id,
      'school_brand': school_brand,
      'features': features.map((e) => e.toMap()).toList(),
      'pinnedAlbumIdList': pinnedAlbumIdList,
      'background': background,
      'isKinderGarten': isKinderGarten,
    };
  }

  String toJson() => json.encode(toMap());
}