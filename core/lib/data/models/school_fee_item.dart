import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_fee_item.g.dart';

@JsonSerializable(explicitToJson: true)
class SchoolFeeItem {
  final String? noidung;
  @JsonKey(name: 'phi_niem_yet')
  final int? phiNiemYet;
  @JsonKey(name: 'giam_gia')
  final String? giamGia;
  @JsonKey(name: 'phai_nop')
  final String? phaiNop;
  @JsonKey(name: 'hoan_tra')
  final String? hoanTra;
  @JsonKey(name: 'han_nop')
  final String? hanNop;
  @JsonKey(name: 'ngay_nop')
  final String? ngayNop;
  @JsonKey(name: 'chua_nop')
  final int? chuaNop;

  SchoolFeeItem({
    this.noidung,
    this.phiNiemYet,
    this.giamGia,
    this.phaiNop,
    this.hoanTra,
    this.hanNop,
    this.ngayNop,
    this.chuaNop,
  });

  factory SchoolFeeItem.fromJson(Map<String, dynamic> json) =>
      _$SchoolFeeItemFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolFeeItemToJson(this);

  @override
  String toString() {
    return 'SchoolFeeItem(noidung: $noidung, phiNiemYet: $phiNiemYet, giamGia: $giamGia, phaiNop: $phaiNop, hoanTra: $hoanTra, hanNop: $hanNop, ngayNop: $ngayNop, chuaNop: $chuaNop)';
  }

  SchoolFeeItem copyWith({
    String? noidung,
    int? phiNiemYet,
    String? giamGia,
    String? phaiNop,
    String? hoanTra,
    String? hanNop,
    String? ngayNop,
    int? chuaNop,
  }) {
    return SchoolFeeItem(
      noidung: noidung ?? this.noidung,
      phiNiemYet: phiNiemYet ?? this.phiNiemYet,
      giamGia: giamGia ?? this.giamGia,
      phaiNop: phaiNop ?? this.phaiNop,
      hoanTra: hoanTra ?? this.hoanTra,
      hanNop: hanNop ?? this.hanNop,
      ngayNop: ngayNop ?? this.ngayNop,
      chuaNop: chuaNop ?? this.chuaNop,
    );
  }
}
