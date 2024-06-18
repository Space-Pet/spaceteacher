import '../../core.dart';
import '../types/types.dart';

class MoetAverage {
  String status;
  String statusNote;
  String txtCurrentYear;
  String txtCurrentHocKy;
  List<String> listYear;
  String txtClassName;
  String txtKhoiId;
  String txtKhoiLevel;
  DiemMoet txtDiemMoet;

  MoetAverage({
    required this.status,
    required this.statusNote,
    required this.txtCurrentYear,
    required this.txtCurrentHocKy,
    required this.listYear,
    required this.txtClassName,
    required this.txtKhoiId,
    required this.txtKhoiLevel,
    required this.txtDiemMoet,
  });

  factory MoetAverage.fromJson(Map<String, dynamic> json) {
    return MoetAverage(
      status: json['status'],
      statusNote: json['status_note'],
      txtCurrentYear: json['txt_current_year'],
      txtCurrentHocKy: json['txt_current_hoc_ky'],
      listYear: List<String>.from(json['list_year']),
      txtClassName: json['txt_class_name'],
      txtKhoiId: json['txt_khoi_id'],
      txtKhoiLevel: json['txt_khoi_level'],
      txtDiemMoet: DiemMoet.fromJson(json['txt_diem_moet']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_note': statusNote,
      'txt_current_year': txtCurrentYear,
      'txt_current_hoc_ky': txtCurrentHocKy,
      'list_year': listYear,
      'txt_class_name': txtClassName,
      'txt_khoi_id': txtKhoiId,
      'txt_khoi_level': txtKhoiLevel,
      'txt_diem_moet': txtDiemMoet.toJson(),
    };
  }

  factory MoetAverage.fromMap(Json data) {
    if (data['txt_class_name'] == null) {
      return MoetAverage.empty();
    }

    return MoetAverage(
      status: data['status'],
      statusNote: data['status_note'],
      txtCurrentYear: data['txt_current_year'],
      txtCurrentHocKy: data['txt_current_hoc_ky'],
      listYear: List<String>.from(data['list_year']),
      txtClassName: data['txt_class_name'],
      txtKhoiId: data['txt_khoi_id'],
      txtKhoiLevel: data['txt_khoi_level'],
      txtDiemMoet: DiemMoet.fromJson(data['txt_diem_moet']),
    );
  }

  factory MoetAverage.empty() {
    return MoetAverage(
      status: '',
      statusNote: '',
      txtCurrentYear: '',
      txtCurrentHocKy: '',
      listYear: [],
      txtClassName: '',
      txtKhoiId: '',
      txtKhoiLevel: '',
      txtDiemMoet: DiemMoet(
        diemTrungBinhHocKy: '',
        ketQuaHocTapHocKy: '',
        ketQuaRenLuyenHocKy: '',
        hocKy: 0,
        diemTrungBinhCaNam: '',
        xepLoaiHanhKiemCaNam: '',
        danhhieuCaNam: '',
        ngayNghiCaNam: '',
        nhanXetGvcnCaNam: '',
      ),
    );
  }
}

class DiemMoet {
  String diemTrungBinhHocKy;
  String ketQuaHocTapHocKy;
  String ketQuaRenLuyenHocKy;
  int hocKy;
  String? diemTrungBinhCaNam;
  String? xepLoaiHocLucCaNam;
  String? xepLoaiHanhKiemCaNam;
  String? danhhieuCaNam;
  String? ngayNghiCaNam;
  String? nhanXetGvcnCaNam;

  DiemMoet({
    required this.diemTrungBinhHocKy,
    required this.ketQuaHocTapHocKy,
    required this.ketQuaRenLuyenHocKy,
    required this.hocKy,
    this.diemTrungBinhCaNam,
    this.xepLoaiHocLucCaNam,
    this.xepLoaiHanhKiemCaNam,
    this.danhhieuCaNam,
    this.ngayNghiCaNam,
    this.nhanXetGvcnCaNam,
  });

  factory DiemMoet.fromJson(Map<String, dynamic> json) {
    // diemTrungBinhHocKy & diemTrungBinhCaNam can be double or int, how to fix this

    return DiemMoet(
      diemTrungBinhHocKy: json['diem_trung_binh_hoc_ky'].toString(),
      ketQuaHocTapHocKy: json['ket_qua_hoc_tap_hoc_ky'],
      ketQuaRenLuyenHocKy: json['ket_qua_ren_luyen_hoc_ky'],
      hocKy: json['hoc_ky'],
      // need to check null  keys below
      diemTrungBinhCaNam: json['diem_trung_binh_ca_nam'] == null
          ? ''
          : json['diem_trung_binh_ca_nam'].toString(),
      xepLoaiHocLucCaNam: json['xep_loai_hoc_luc_ca_nam'] ?? '',
      xepLoaiHanhKiemCaNam: json['xep_loai_hanh_kiem_ca_nam'] ?? '',
      danhhieuCaNam: json['danhhieu_ca_nam'] ?? '',
      ngayNghiCaNam: json['ngay_nghi_ca_nam'] ?? '',
      nhanXetGvcnCaNam: json['nhan_xet_gvcn_ca_nam'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diem_trung_binh_hoc_ky': diemTrungBinhHocKy,
      'ket_qua_hoc_tap_hoc_ky': ketQuaHocTapHocKy,
      'ket_qua_ren_luyen_hoc_ky': ketQuaRenLuyenHocKy,
      'hoc_ky': hocKy,
      'diem_trung_binh_ca_nam': diemTrungBinhCaNam,
      'xep_loai_hoc_luc_ca_nam': xepLoaiHocLucCaNam,
      'xep_loai_hanh_kiem_ca_nam': xepLoaiHanhKiemCaNam,
      'danhhieu_ca_nam': danhhieuCaNam,
      'ngay_nghi_ca_nam': ngayNghiCaNam,
      'nhan_xet_gvcn_ca_nam': nhanXetGvcnCaNam,
    };
  }
}
