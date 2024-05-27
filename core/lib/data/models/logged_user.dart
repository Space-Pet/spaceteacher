// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../hive_models/hive_models.dart';

part 'logged_user.g.dart';

@HiveType(typeId: 15)
class LoggedUser {
  @HiveField(0)
  final String user_key;
  @HiveField(1)
  final List<FeatureModel> features;
  @HiveField(2)
  final List<int> pinnedAlbumIdList;

  LoggedUser({
    required this.user_key,
    required this.features,
    required this.pinnedAlbumIdList,
  });

  LoggedUser copyWith({
    String? user_key,
    List<FeatureModel>? features,
    List<int>? pinnedAlbumIdList,
  }) {
    return LoggedUser(
      user_key: user_key ?? this.user_key,
      features: features ?? this.features,
      pinnedAlbumIdList: pinnedAlbumIdList ?? this.pinnedAlbumIdList,
    );
  }

  factory LoggedUser.empty() {
    return LoggedUser(
      user_key: '',
      features: [],
      pinnedAlbumIdList: [],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_key': user_key,
      'features': features.map((x) => x.toMap()).toList(),
      'pinnedAlbumIdList': pinnedAlbumIdList,
    };
  }

  factory LoggedUser.fromMap(Map<String, dynamic> map) {
    return LoggedUser(
      user_key: map['user_key'] as String,
      features: List<FeatureModel>.from(map['features']
              ?.map((x) => FeatureModel.fromMap(x as Map<String, dynamic>))
          as Iterable),
      pinnedAlbumIdList: List<int>.from(map['pinnedAlbumIdList'] as Iterable),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoggedUser.fromJson(String source) =>
      LoggedUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
