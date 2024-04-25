import 'package:json_annotation/json_annotation.dart';

import 'package:teacher/model/primary_school_moet_score_model.dart';
part 'primary_school_score_model.g.dart';

@JsonSerializable()
class PrimarySchoolScoreModel {
  final String? status;
  @JsonKey(name: 'status_note')
  final String? statusNote;
  @JsonKey(name: 'txt_current_year')
  final String? txtCurrentYear;
  @JsonKey(name: 'txt_current_hoc_ky')
  final String? txtCurrentHocKy;
  @JsonKey(name: 'list_year')
  final List<String>? listYear;
  @JsonKey(name: 'txt_class_name')
  final String? txtClassName;
  @JsonKey(name: 'txt_khoi_id')
  final String? txtKhoiId;
  @JsonKey(name: 'txt_khoi_level')
  final String? txtKhoiLevel;
  @JsonKey(name: 'txt_diem_moet')
  final PrimarySchoolMoetScoreModel? txtDiemMoet;

  PrimarySchoolScoreModel({
    this.status,
    this.statusNote,
    this.txtCurrentYear,
    this.txtCurrentHocKy,
    this.listYear,
    this.txtClassName,
    this.txtKhoiId,
    this.txtKhoiLevel,
    this.txtDiemMoet,
  });

  factory PrimarySchoolScoreModel.fromJson(Map<String, dynamic> json) =>
      _$PrimarySchoolScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrimarySchoolScoreModelToJson(this);

  @override
  String toString() {
    return 'PrimarySchoolScoreModel{status: $status, statusNote: $statusNote, txtCurrentYear: $txtCurrentYear, txtCurrentHocKy: $txtCurrentHocKy, listYear: $listYear, txtClassName: $txtClassName, txtKhoiId: $txtKhoiId, txtKhoiLevel: $txtKhoiLevel, txtDiemMoet: $txtDiemMoet}';
  }

  PrimarySchoolScoreModel copyWith({
    String? status,
    String? statusNote,
    String? txtCurrentYear,
    String? txtCurrentHocKy,
    List<String>? listYear,
    String? txtClassName,
    String? txtKhoiId,
    String? txtKhoiLevel,
    PrimarySchoolMoetScoreModel? txtDiemMoet,
  }) {
    return PrimarySchoolScoreModel(
      status: status ?? this.status,
      statusNote: statusNote ?? this.statusNote,
      txtCurrentYear: txtCurrentYear ?? this.txtCurrentYear,
      txtCurrentHocKy: txtCurrentHocKy ?? this.txtCurrentHocKy,
      listYear: listYear ?? this.listYear,
      txtClassName: txtClassName ?? this.txtClassName,
      txtKhoiId: txtKhoiId ?? this.txtKhoiId,
      txtKhoiLevel: txtKhoiLevel ?? this.txtKhoiLevel,
      txtDiemMoet: txtDiemMoet ?? this.txtDiemMoet,
    );
  }
}
