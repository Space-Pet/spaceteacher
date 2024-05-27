// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive/hive.dart';

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

  LocalFeatures({
    required this.user_key,
    required this.features,
    this.pinnedAlbumIdList,
  });

  LocalFeatures copyWith({
    String? user_key,
    List<FeatureModel>? features,
    List<int>? pinnedAlbumIdList,
  }) {
    return LocalFeatures(
      user_key: user_key ?? this.user_key,
      features: features ?? this.features,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_key': user_key,
      'features': features.map((x) => x.toMap()).toList(),
      'pinnedAlbumIdList': pinnedAlbumIdList ?? <int>[],
    };
  }

  factory LocalFeatures.fromMap(Map<String, dynamic> map) {
    return LocalFeatures(
      user_key: map['user_key'] as String,
      features: List<FeatureModel>.from(map['features']
              ?.map((x) => FeatureModel.fromMap(x as Map<String, dynamic>))
          as Iterable),
      pinnedAlbumIdList: List<int>.from(map['pinnedAlbumIdList'] as Iterable),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalFeatures.fromJson(String source) =>
      LocalFeatures.fromMap(json.decode(source) as Map<String, dynamic>);
}
