import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'local_training_level.g.dart';

@HiveType(typeId: 14)
class LocalTrainingLevel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  LocalTrainingLevel({
    required this.id,
    required this.name,
  });

  LocalTrainingLevel copyWith({
    String? id,
    String? name,
  }) {
    return LocalTrainingLevel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory LocalTrainingLevel.fromMap(Map<String, dynamic> map) {
    return LocalTrainingLevel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalTrainingLevel.fromJson(String source) =>
      LocalTrainingLevel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocalTrainingLevel(id: $id, name: $name)';
}
