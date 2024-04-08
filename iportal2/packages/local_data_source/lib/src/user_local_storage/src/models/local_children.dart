// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'local_url_image.dart';

part 'local_children.g.dart';

@HiveType(typeId: 4)
class LocalChildren {
  @HiveField(0)
  final int pupil_id;
  @HiveField(1)
  final String user_id;
  @HiveField(2)
  final String birthday;
  @HiveField(3)
  final int school_id;
  @HiveField(4)
  final String school_name;
  @HiveField(5)
  final int class_id;
  @HiveField(6)
  final int customer_id;
  @HiveField(7)
  final String learn_year;
  @HiveField(8)
  final String full_name;
  @HiveField(9)
  final String user_key;
  @HiveField(10)
  final int parent_id;
  @HiveField(11)
  final String class_name;
  @HiveField(12)
  final LocalUrlImage url_image;

  LocalChildren({
    required this.pupil_id,
    required this.user_id,
    required this.birthday,
    required this.school_id,
    required this.school_name,
    required this.class_id,
    required this.customer_id,
    required this.learn_year,
    required this.full_name,
    required this.user_key,
    required this.parent_id,
    required this.class_name,
    required this.url_image,
  });

  LocalChildren copyWith({
    int? pupil_id,
    String? user_id,
    String? birthday,
    int? school_id,
    String? school_name,
    int? class_id,
    int? customer_id,
    String? learn_year,
    String? full_name,
    String? user_key,
    int? parent_id,
    String? class_name,
    LocalUrlImage? url_image,
  }) {
    return LocalChildren(
      pupil_id: pupil_id ?? this.pupil_id,
      user_id: user_id ?? this.user_id,
      birthday: birthday ?? this.birthday,
      school_id: school_id ?? this.school_id,
      school_name: school_name ?? this.school_name,
      class_id: class_id ?? this.class_id,
      customer_id: customer_id ?? this.customer_id,
      learn_year: learn_year ?? this.learn_year,
      full_name: full_name ?? this.full_name,
      user_key: user_key ?? this.user_key,
      parent_id: parent_id ?? this.parent_id,
      class_name: class_name ?? this.class_name,
      url_image: url_image ?? this.url_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pupil_id': pupil_id,
      'user_id': user_id,
      'birthday': birthday,
      'school_id': school_id,
      'school_name': school_name,
      'class_id': class_id,
      'customer_id': customer_id,
      'learn_year': learn_year,
      'full_name': full_name,
      'user_key': user_key,
      'parent_id': parent_id,
      'class_name': class_name,
      'url_image': url_image.toMap(),
    };
  }

  factory LocalChildren.fromMap(Map<String, dynamic> map) {
    return LocalChildren(
      pupil_id: map['pupil_id'].toInt() as int,
      user_id: map['user_id'] as String,
      birthday: map['birthday'] as String,
      school_id: map['school_id'].toInt() as int,
      school_name: map['school_name'] as String,
      class_id: map['class_id'].toInt() as int,
      customer_id: map['customer_id'].toInt() as int,
      learn_year: map['learn_year'] as String,
      full_name: map['full_name'] as String,
      user_key: map['user_key'] as String,
      parent_id: map['parent_id'].toInt() as int,
      class_name: map['class_name'] as String,
      url_image:
          LocalUrlImage.fromMap(map['url_image'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalChildren.fromJson(String source) =>
      LocalChildren.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocalChildren(pupil_id: $pupil_id, user_id: $user_id, birthday: $birthday, school_id: $school_id, school_name: $school_name, class_id: $class_id, customer_id: $customer_id, learn_year: $learn_year, full_name: $full_name, user_key: $user_key, parent_id: $parent_id, class_name: $class_name, url_image: $url_image)';
  }
}
