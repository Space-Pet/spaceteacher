import 'dart:convert';

import 'package:hive/hive.dart';
import 'local_children.dart';
import 'local_user_features.dart';

part 'local_features.g.dart';

@HiveType(typeId: 11)
class LocalFeatures {
  @HiveField(0)
  final String user_key;
  @HiveField(1)
  final List<FeatureModel> features;
  @HiveField(2)
  final List<int>? pinnedAlbumIdList;
  @HiveField(3)
  final List<LocalChildren> children;

  LocalFeatures({
    required this.user_key,
    required this.features,
    this.pinnedAlbumIdList,
    required this.children,
  });

  LocalFeatures copyWith({
    String? user_key,
    List<FeatureModel>? features,
    List<int>? pinnedAlbumIdList,
    List<LocalChildren>? children,
  }) {
    return LocalFeatures(
      user_key: user_key ?? this.user_key,
      features: features ?? this.features,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
      children: children ?? this.children,
    );
  }

  factory LocalFeatures.fromMap(Map<String, dynamic> map) {
    return LocalFeatures(
      user_key: map['user_key'] as String,
      features: List<FeatureModel>.from(map['features']
              ?.map((x) => FeatureModel.fromMap(x as Map<String, dynamic>))
          as Iterable),
      pinnedAlbumIdList: List<int>.from(map['pinnedAlbumIdList'] as Iterable),
      children: List<LocalChildren>.from(map['children']
              ?.map((x) => LocalChildren.fromMap(x as Map<String, dynamic>))
          as Iterable),
    );
  }

  factory LocalFeatures.empty() {
    return LocalFeatures(
      user_key: '',
      features: [],
      pinnedAlbumIdList: [],
      children: [],
    );
  }

  factory LocalFeatures.fromJson(String source) =>
      LocalFeatures.fromMap(json.decode(source) as Map<String, dynamic>);
}
