import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_school_fee_item.g.dart';

@JsonSerializable(explicitToJson: true)
class HistorySchoolFeeItem {
  @JsonKey(name: 'pupil_fee_his_id')
  final int? pupilFeeHisId;
  @JsonKey(name: 'so_phieu_thu')
  final String? soPhieuThu;
  @JsonKey(name: 'hinh_thuc_thanh_toan')
  final String? hinhThucThanhToan;
  @JsonKey(name: 'so_tien')
  final String? soTien;
  @JsonKey(name: 'chi_tiet_phi_thu')
  final List<ChiTietPhieuThu>? chiTietPhiThu;
  @JsonKey(name: 'ngay_thu')
  final String? ngayThu;

  HistorySchoolFeeItem({
    this.pupilFeeHisId,
    this.soPhieuThu,
    this.hinhThucThanhToan,
    this.soTien,
    this.chiTietPhiThu = const [],
    this.ngayThu,
  });

  factory HistorySchoolFeeItem.fromJson(Map<String, dynamic> json) =>
      _$HistorySchoolFeeItemFromJson(json);

  Map<String, dynamic> toJson() => _$HistorySchoolFeeItemToJson(this);

  @override
  String toString() {
    return 'HistorySchoolFeeItem(pupilFeeHisId: $pupilFeeHisId, soPhieuThu: $soPhieuThu, hinhThucThanhToan: $hinhThucThanhToan, soTien: $soTien, chiTietPhiThu: $chiTietPhiThu, ngayThu: $ngayThu)';
  }

  HistorySchoolFeeItem copyWith({
    int? pupilFeeHisId,
    String? soPhieuThu,
    String? hinhThucThanhToan,
    String? soTien,
    List<ChiTietPhieuThu>? chiTietPhiThu,
    String? ngayThu,
  }) {
    return HistorySchoolFeeItem(
      pupilFeeHisId: pupilFeeHisId ?? this.pupilFeeHisId,
      soPhieuThu: soPhieuThu ?? this.soPhieuThu,
      hinhThucThanhToan: hinhThucThanhToan ?? this.hinhThucThanhToan,
      soTien: soTien ?? this.soTien,
      chiTietPhiThu: chiTietPhiThu ?? this.chiTietPhiThu,
      ngayThu: ngayThu ?? this.ngayThu,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ChiTietPhieuThu {
  final String? noidung;
  @JsonKey(name: 'giam_gia')
  final String? giamGia;
  @JsonKey(name: 'thanh_tien')
  final String? thanhTien;
  @JsonKey(name: 'so_tien')
  final int? soTien;

  ChiTietPhieuThu({
    this.noidung,
    this.giamGia,
    this.thanhTien,
    this.soTien,
  });

  factory ChiTietPhieuThu.fromJson(Map<String, dynamic> json) =>
      _$ChiTietPhieuThuFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietPhieuThuToJson(this);

  @override
  String toString() {
    return 'ChiTietPhieuThu(noidung: $noidung, giamGia: $giamGia, thanhTien: $thanhTien, soTien: $soTien)';
  }

  ChiTietPhieuThu copyWith({
    String? noidung,
    String? giamGia,
    String? thanhTien,
    int? soTien,
  }) {
    return ChiTietPhieuThu(
      noidung: noidung ?? this.noidung,
      giamGia: giamGia ?? this.giamGia,
      thanhTien: thanhTien ?? this.thanhTien,
      soTien: soTien ?? this.soTien,
    );
  }
}
