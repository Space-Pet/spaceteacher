import 'dart:convert';

import 'package:hive/hive.dart';


part 'local_url_image.g.dart';

@HiveType(typeId: 6)
class LocalUrlImage {
  @HiveField(0)
  final String web;
  @HiveField(1)
  final String mobile;

  LocalUrlImage({
    required this.web,
    required this.mobile,
  });

  LocalUrlImage copyWith({
    String? web,
    String? mobile,
  }) {
    return LocalUrlImage(
      web: web ?? this.web,
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'web': web,
      'mobile': mobile,
    };
  }

  factory LocalUrlImage.fromMap(Map<String, dynamic> map) {
    return LocalUrlImage(
      web: map['web'] as String,
      mobile: map['mobile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUrlImage.fromJson(String source) =>
      LocalUrlImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocalUrlImage(web: $web, mobile: $mobile)';
}
