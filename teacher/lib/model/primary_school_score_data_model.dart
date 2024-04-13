import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/semester_score_model.dart';
part 'primary_school_score_data_model.g.dart';

@JsonSerializable()
class PrimarySchoolScoreDataModel {
  @JsonKey(name: 'subject_id')
  final String? subjectId;
  @JsonKey(name: 'subject_name')
  final String? subjectName;
  @JsonKey(name: 'diem_giua_hk1')
  final SemesterScoreModel diemGiuaHk1;
  @JsonKey(name: 'diem_giua_hk2')
  final SemesterScoreModel diemGiuaHk2;
  @JsonKey(name: 'diem_cuoi_hk1')
  final SemesterScoreModel diemCuoiHk1;
  @JsonKey(name: 'diem_cuoi_nam')
  final SemesterScoreModel diemCuoiNam;

  PrimarySchoolScoreDataModel({
    this.subjectId,
    this.subjectName,
    required this.diemGiuaHk1,
    required this.diemGiuaHk2,
    required this.diemCuoiHk1,
    required this.diemCuoiNam,
  });

  factory PrimarySchoolScoreDataModel.fromJson(Map<String, dynamic> json) =>
      _$PrimarySchoolScoreDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrimarySchoolScoreDataModelToJson(this);

  @override
  String toString() {
    return 'PrimarySchoolScoreDataModel{subjectId: $subjectId, subjectName: $subjectName, diemGiuaHk1: $diemGiuaHk1, diemGiuaHk2: $diemGiuaHk2, diemCuoiHk1: $diemCuoiHk1, diemCuoiNam: $diemCuoiNam}';
  }

  PrimarySchoolScoreDataModel copyWith({
    String? subjectId,
    String? subjectName,
    SemesterScoreModel? diemGiuaHk1,
    SemesterScoreModel? diemGiuaHk2,
    SemesterScoreModel? diemCuoiHk1,
    SemesterScoreModel? diemCuoiNam,
  }) {
    return PrimarySchoolScoreDataModel(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      diemGiuaHk1: diemGiuaHk1 ?? this.diemGiuaHk1,
      diemGiuaHk2: diemGiuaHk2 ?? this.diemGiuaHk2,
      diemCuoiHk1: diemCuoiHk1 ?? this.diemCuoiHk1,
      diemCuoiNam: diemCuoiNam ?? this.diemCuoiNam,
    );
  }
}
