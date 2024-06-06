import 'package:json_annotation/json_annotation.dart';

part 'school_fee_payment_preview.g.dart';

@JsonSerializable()
class SchoolFeePaymentPreview {
  @JsonKey(name: 'items')
  final List<SchoolFeePaymentPreviewItem>? items;
  @JsonKey(name: 'tong_phi_niem_yet')
  final int? tongPhiNiemYet;
  @JsonKey(name: 'tong_giam_gia')
  final int? tongGiamGia;
  @JsonKey(name: 'tong_phai_nop')
  final int? tongPhaiNop;
  @JsonKey(name: 'tong_thanh_toan')
  final int? tongThanhToan;

  SchoolFeePaymentPreview({
    this.items,
    this.tongPhiNiemYet,
    this.tongGiamGia,
    this.tongPhaiNop,
    this.tongThanhToan,
  });

  factory SchoolFeePaymentPreview.fromJson(Map<String, dynamic> json) =>
      _$SchoolFeePaymentPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolFeePaymentPreviewToJson(this);

  @override
  String toString() {
    return 'SchoolFeePaymentPreview{items: $items, tongPhiNiemYet: $tongPhiNiemYet, tongGiamGia: $tongGiamGia, tongPhaiNop: $tongPhaiNop, tongThanhToan: $tongThanhToan}';
  }

  SchoolFeePaymentPreview copyWith({
    List<SchoolFeePaymentPreviewItem>? items,
    int? tongPhiNiemYet,
    int? tongGiamGia,
    int? tongPhaiNop,
    int? tongThanhToan,
  }) {
    return SchoolFeePaymentPreview(
      items: items ?? this.items,
      tongPhiNiemYet: tongPhiNiemYet ?? this.tongPhiNiemYet,
      tongGiamGia: tongGiamGia ?? this.tongGiamGia,
      tongPhaiNop: tongPhaiNop ?? this.tongPhaiNop,
      tongThanhToan: tongThanhToan ?? this.tongThanhToan,
    );
  }
}

@JsonSerializable()
class SchoolFeePaymentPreviewItem {
  @JsonKey(name: 'do_uu_tien')
  final String? doUuTien;
  @JsonKey(name: 'noi_dung')
  final String? noiDung;
  @JsonKey(name: 'phi_niem_yet')
  final int? phiNiemYet;
  @JsonKey(name: 'giam_gia')
  final String? giamGia;
  @JsonKey(name: 'phai_nop')
  final int? phaiNop;
  @JsonKey(name: 'thuc_thu')
  final int? thucThu;

  SchoolFeePaymentPreviewItem({
    this.doUuTien,
    this.noiDung,
    this.phiNiemYet,
    this.giamGia,
    this.phaiNop,
    this.thucThu,
  });

  factory SchoolFeePaymentPreviewItem.fromJson(Map<String, dynamic> json) =>
      _$SchoolFeePaymentPreviewItemFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolFeePaymentPreviewItemToJson(this);

  @override
  String toString() {
    return 'SchoolFeePaymentPreviewItem{doUuTien: $doUuTien, noiDung: $noiDung, phiNiemYet: $phiNiemYet, giamGia: $giamGia, phaiNop: $phaiNop, thucThu: $thucThu}';
  }

  SchoolFeePaymentPreviewItem copyWith({
    String? doUuTien,
    String? noiDung,
    int? phiNiemYet,
    String? giamGia,
    int? phaiNop,
    int? thucThu,
  }) {
    return SchoolFeePaymentPreviewItem(
      doUuTien: doUuTien ?? this.doUuTien,
      noiDung: noiDung ?? this.noiDung,
      phiNiemYet: phiNiemYet ?? this.phiNiemYet,
      giamGia: giamGia ?? this.giamGia,
      phaiNop: phaiNop ?? this.phaiNop,
      thucThu: thucThu ?? this.thucThu,
    );
  }
}
