import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/conduct_detail_model.dart';
part 'conduct_primary_school_data_model.g.dart';

@JsonSerializable()
class ConductPrimarySchoolDataModel {
  @JsonKey(name: 'nang_luc_cot_loi')
  final CoreCompetenciesModel? coreCompetencies;
  @JsonKey(name: 'pham_chat_chu_yeu')
  final List<ConductDetailModel>? phamChatChuYeu;
  @JsonKey(name: 'nhan_xet_chung_cua_gvcn')
  final List<ConductDetailModel>? nhanXetChungCuaGVCN;

  ConductPrimarySchoolDataModel({
    this.coreCompetencies,
    this.phamChatChuYeu,
    this.nhanXetChungCuaGVCN,
  });

  factory ConductPrimarySchoolDataModel.fromJson(Map<String, dynamic> json) =>
      _$ConductPrimarySchoolDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConductPrimarySchoolDataModelToJson(this);

  @override
  String toString() {
    return 'ConductPrimarySchoolDataModel{coreCompetencies: $coreCompetencies, phamChatChuYeu: $phamChatChuYeu, nhanXetChungCuaGVCN: $nhanXetChungCuaGVCN}';
  }

  ConductPrimarySchoolDataModel copyWith({
    CoreCompetenciesModel? coreCompetencies,
    List<ConductDetailModel>? phamChatChuYeu,
    List<ConductDetailModel>? nhanXetChungCuaGVCN,
  }) {
    return ConductPrimarySchoolDataModel(
      coreCompetencies: coreCompetencies ?? this.coreCompetencies,
      phamChatChuYeu: phamChatChuYeu ?? this.phamChatChuYeu,
      nhanXetChungCuaGVCN: nhanXetChungCuaGVCN ?? this.nhanXetChungCuaGVCN,
    );
  }
}

@JsonSerializable()
class CoreCompetenciesModel {
  @JsonKey(name: 'nang_luc_chung')
  final List<ConductDetailModel>? nangLucChung;
  @JsonKey(name: 'nang_luc_dac_thu')
  final List<ConductDetailModel>? nangLucDacThu;

  CoreCompetenciesModel({
    this.nangLucChung,
    this.nangLucDacThu,
  });

  factory CoreCompetenciesModel.fromJson(Map<String, dynamic> json) =>
      _$CoreCompetenciesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoreCompetenciesModelToJson(this);

  @override
  String toString() {
    return 'CoreCompetenciesModel{nangLucChung: $nangLucChung, nangLucDacThu: $nangLucDacThu}';
  }

  CoreCompetenciesModel copyWith({
    List<ConductDetailModel>? nangLucChung,
    List<ConductDetailModel>? nangLucDacThu,
  }) {
    return CoreCompetenciesModel(
      nangLucChung: nangLucChung ?? this.nangLucChung,
      nangLucDacThu: nangLucDacThu ?? this.nangLucDacThu,
    );
  }
}
