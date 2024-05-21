import 'package:json_annotation/json_annotation.dart';
part 'score_model.g.dart';

@JsonSerializable()
class ScoreModel {
  @JsonKey(name: 'SUBJECT_ID')
  final String? subjectId;
  @JsonKey(name: 'SUBJECT_NAME')
  final String? subjectName;
  final List<String>? ddgtx;
  final String? ddggk;
  final String? ddgck;
  final double? tbmhk;

  ScoreModel({
    this.subjectId,
    this.subjectName,
    this.ddgtx,
    this.ddggk,
    this.ddgck,
    this.tbmhk,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) =>
      _$ScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreModelToJson(this);

  @override
  String toString() {
    return 'ScoreModel{subjectId: $subjectId, subjectName: $subjectName, ddgtx: $ddgtx, ddggk: $ddggk, ddgck: $ddgck, tbmhk: $tbmhk}';
  }

  ScoreModel copyWith({
    String? subjectId,
    String? subjectName,
    List<String>? ddgtx,
    String? ddggk,
    String? ddgck,
    double? tbmhk,
  }) {
    return ScoreModel(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      ddgtx: ddgtx ?? this.ddgtx,
      ddggk: ddggk ?? this.ddggk,
      ddgck: ddgck ?? this.ddgck,
      tbmhk: tbmhk ?? this.tbmhk,
    );
  }
}
