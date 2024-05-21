import 'package:json_annotation/json_annotation.dart';
part 'semester_score_model.g.dart';

@JsonSerializable()
class SemesterScoreModel {
  @JsonKey(name: 'muc_dat_duoc')
  final String? mucDatDuoc;
  @JsonKey(name: 'diem_ktdk')
  final String? diemKtdk;
  @JsonKey(name: 'nhan_xet')
  final String? nhanXet;

  SemesterScoreModel({
    this.mucDatDuoc,
    this.diemKtdk,
    this.nhanXet,
  });

  factory SemesterScoreModel.fromJson(Map<String, dynamic> json) =>
      _$SemesterScoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$SemesterScoreModelToJson(this);

  @override
  String toString() {
    return 'SemesterScoreModel{mucDatDuoc: $mucDatDuoc, diemKtdk: $diemKtdk, nhanXet: $nhanXet}';
  }

  SemesterScoreModel copyWith({
    String? mucDatDuoc,
    String? diemKtdk,
    String? nhanXet,
  }) {
    return SemesterScoreModel(
      mucDatDuoc: mucDatDuoc ?? this.mucDatDuoc,
      diemKtdk: diemKtdk ?? this.diemKtdk,
      nhanXet: nhanXet ?? this.nhanXet,
    );
  }
}
