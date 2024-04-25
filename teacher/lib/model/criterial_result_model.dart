import 'package:json_annotation/json_annotation.dart';
part 'criterial_result_model.g.dart';

@JsonSerializable()
class CriterialResultModel {
  final int? id;
  @JsonKey(name: 'pupil_id')
  final int? pupilID;
  @JsonKey(name: 'mark_id')
  final int? markID;
  @JsonKey(name: 'text_result')
  final String? textResult;

  CriterialResultModel({
    this.id,
    this.pupilID,
    this.markID,
    this.textResult,
  });

  factory CriterialResultModel.fromJson(Map<String, dynamic> json) =>
      _$CriterialResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$CriterialResultModelToJson(this);

  @override
  String toString() {
    return 'CriterialResultModel{id: $id, pupilID: $pupilID, markID: $markID, textResult: $textResult}';
  }

  CriterialResultModel copyWith({
    int? id,
    int? pupilID,
    int? markID,
    String? textResult,
  }) {
    return CriterialResultModel(
      id: id ?? this.id,
      pupilID: pupilID ?? this.pupilID,
      markID: markID ?? this.markID,
      textResult: textResult ?? this.textResult,
    );
  }
}
