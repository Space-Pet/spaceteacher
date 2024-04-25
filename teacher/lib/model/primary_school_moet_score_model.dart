import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/conduct_model.dart';
import 'package:teacher/model/primary_school_score_data_model.dart';
part 'primary_school_moet_score_model.g.dart';

@JsonSerializable()
class PrimarySchoolMoetScoreModel {
  @JsonKey(name: 'diem_data')
  final List<PrimarySchoolScoreDataModel> diemData;
  @JsonKey(name: 'hanh_kiem_data')
  final ConductModel? hanhKiemData;
  @JsonKey(name: 'nhan_xet_chung_cua_gvcn')
  final String? nhanXetChungCuaGvcn;

  PrimarySchoolMoetScoreModel({
    required this.diemData,
    this.hanhKiemData,
    this.nhanXetChungCuaGvcn,
  });

  factory PrimarySchoolMoetScoreModel.fromJson(Map<String, dynamic> json) =>
      _$PrimarySchoolMoetScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrimarySchoolMoetScoreModelToJson(this);

  @override
  String toString() {
    return 'PrimarySchoolMoetScoreModel{diemData: $diemData, hanhKiemData: $hanhKiemData, nhanXetChungCuaGvcn: $nhanXetChungCuaGvcn}';
  }

  PrimarySchoolMoetScoreModel copyWith({
    List<PrimarySchoolScoreDataModel>? diemData,
    ConductModel? hanhKiemData,
    String? nhanXetChungCuaGvcn,
  }) {
    return PrimarySchoolMoetScoreModel(
      diemData: diemData ?? this.diemData,
      hanhKiemData: hanhKiemData ?? this.hanhKiemData,
      nhanXetChungCuaGvcn: nhanXetChungCuaGvcn ?? this.nhanXetChungCuaGvcn,
    );
  }
}
