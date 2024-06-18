// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive/hive.dart';
import 'local_children.dart';

part 'local_iportal_profile.g.dart';

@HiveType(typeId: 3)
class LocalIPortalProfile {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String user_key;
  @HiveField(2)
  final int user_id;
  @HiveField(3)
  final int type;
  @HiveField(4)
  final String type_text;
  @HiveField(5)
  final String learn_year;
  @HiveField(6)
  final List<LocalChildren> children;

  LocalIPortalProfile({
    required this.name,
    required this.user_key,
    required this.user_id,
    required this.type,
    required this.type_text,
    required this.learn_year,
    required this.children,
  });

  bool isStudent() {
    return type != 2;
  }

  LocalIPortalProfile copyWith({
    String? name,
    String? user_key,
    int? user_id,
    int? type,
    String? type_text,
    String? learn_year,
    List<LocalChildren>? children,
  }) {
    return LocalIPortalProfile(
      name: name ?? this.name,
      user_key: user_key ?? this.user_key,
      user_id: user_id ?? this.user_id,
      type: type ?? this.type,
      type_text: type_text ?? this.type_text,
      learn_year: learn_year ?? this.learn_year,
      children: children ?? this.children,
    );
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
      type: map['type'].toInt() as int,
      type_text: map['type_text'] as String,
      learn_year: map['learn_year'] as String,
      children: children,
    );
  }

  factory LocalIPortalProfile.fromJson(String source) =>
      LocalIPortalProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  factory LocalIPortalProfile.empty() {
    return LocalIPortalProfile(
      name: '',
      user_key: '',
      user_id: 0,
      type: 0,
      type_text: '',
      learn_year: '',
      children: [],
    );
  }
}
