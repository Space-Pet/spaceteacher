import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/score_model.dart';
part 'moet_score_model.g.dart';

@JsonSerializable()
class MoetScoreModel {
  @JsonKey(name: 'score_data')
  final List<ScoreModel>? scoreData;
  final String? kqht;
  final String? kqrl;
  @JsonKey(name: 'hoc_ky')
  final int? hocKy;
  @JsonKey(name: 'dtb_cn')
  final double? dtbCN;
  @JsonKey(name: 'xlhl_cn')
  final String? xlhlCN;
  @JsonKey(name: 'xlhk_cn')
  final String? xlhkCN;
  @JsonKey(name: 'danhhieu_cn')
  final String? danhhieuCN;
  @JsonKey(name: 'ngay_nghi_cn')
  final String? ngayNghiCN;
  @JsonKey(name: 'nhan_xet_gvcn_cn')
  final String? nhanXetGVCNCN;

  MoetScoreModel({
    this.scoreData,
    this.kqht,
    this.kqrl,
    this.hocKy,
    this.dtbCN,
    this.xlhlCN,
    this.xlhkCN,
    this.danhhieuCN,
    this.ngayNghiCN,
    this.nhanXetGVCNCN,
  });

  factory MoetScoreModel.fromJson(Map<String, dynamic> json) =>
      _$MoetScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoetScoreModelToJson(this);

  @override
  String toString() {
    return 'MoetScoreModel{scoreData: $scoreData, kqht: $kqht, kqrl: $kqrl, hocKy: $hocKy, dtbCN: $dtbCN, xlhlCN: $xlhlCN, xlhkCN: $xlhkCN, danhhieuCN: $danhhieuCN, ngayNghiCN: $ngayNghiCN, nhanXetGVCNCN: $nhanXetGVCNCN}';
  }

  MoetScoreModel copyWith({
    List<ScoreModel>? scoreData,
    String? kqht,
    String? kqrl,
    int? hocKy,
    double? dtbCN,
    String? xlhlCN,
    String? xlhkCN,
    String? danhhieuCN,
    String? ngayNghiCN,
    String? nhanXetGVCNCN,
  }) {
    return MoetScoreModel(
      scoreData: scoreData ?? this.scoreData,
      kqht: kqht ?? this.kqht,
      kqrl: kqrl ?? this.kqrl,
      hocKy: hocKy ?? this.hocKy,
      dtbCN: dtbCN ?? this.dtbCN,
      xlhlCN: xlhlCN ?? this.xlhlCN,
      xlhkCN: xlhkCN ?? this.xlhkCN,
      danhhieuCN: danhhieuCN ?? this.danhhieuCN,
      ngayNghiCN: ngayNghiCN ?? this.ngayNghiCN,
      nhanXetGVCNCN: nhanXetGVCNCN ?? this.nhanXetGVCNCN,
    );
  }
}
