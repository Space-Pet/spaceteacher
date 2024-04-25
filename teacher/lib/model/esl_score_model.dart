import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/esl_data_model.dart';
part 'esl_score_model.g.dart';

@JsonSerializable()
class EslScoreModel {
  @JsonKey(name: 'pupil_id')
  final String? pupilId;
  @JsonKey(name: 'txt_hoc_ky')
  final String? hocKy;
  @JsonKey(name: 'txt_learn_year')
  final String? learnYear;
  @JsonKey(name: 'data')
  final List<EslDataModel>? listEslData;

  EslScoreModel({this.pupilId, this.hocKy, this.learnYear, this.listEslData});

  factory EslScoreModel.fromJson(Map<String, dynamic> json) =>
      _$EslScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$EslScoreModelToJson(this);

  @override
  String toString() {
    return 'EslScoreModel{pupilId: $pupilId, hocKy: $hocKy, learnYear: $learnYear, listEslData: $listEslData}';
  }

  EslScoreModel copyWith({
    String? pupilId,
    String? hocKy,
    String? learnYear,
    List<EslDataModel>? listEslData,
  }) {
    return EslScoreModel(
      pupilId: pupilId ?? this.pupilId,
      hocKy: hocKy ?? this.hocKy,
      learnYear: learnYear ?? this.learnYear,
      listEslData: listEslData ?? this.listEslData,
    );
  }
}
