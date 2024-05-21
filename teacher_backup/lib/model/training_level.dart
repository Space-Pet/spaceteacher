import 'package:json_annotation/json_annotation.dart';

part 'training_level.g.dart';

@JsonSerializable()
class TrainingLevel {
  final String? id;
  final String? name;

  TrainingLevel({
    this.id,
    this.name,
  });

  factory TrainingLevel.fromJson(Map<String, dynamic> json) =>
      _$TrainingLevelFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingLevelToJson(this);

  @override
  String toString() {
    return 'TrainingLevel{id: $id, name: $name}';
  }
}
