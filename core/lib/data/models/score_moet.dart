import 'dart:convert';

import 'package:intl/intl.dart';

class ScoreModel {
  final String txtLearnYear;
  final String txtHocKy;
  final String txtClassName;
  final TxtDiemMoetType txtDiem;
  final String statusNote;

  ScoreModel({
    required this.txtDiem,
    required this.txtLearnYear,
    required this.txtHocKy,
    required this.txtClassName,
    required this.statusNote,
  });

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    if (map['txt_class_name'] == null) {
      return ScoreModel.empty();
    }

    return ScoreModel(
      txtDiem: map['txt_diem'] == null
          ? TxtDiemMoetType.empty()
          : TxtDiemMoetType.fromMap(map['txt_diem']),
      txtLearnYear: map['txt_learn_year'],
      txtHocKy: map['txt_hoc_ky'],
      txtClassName: map['txt_class_name'],
      statusNote: map['status_note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'txt_diem': txtDiem.toMap(),
      'txt_learn_year': txtLearnYear,
      'txt_hoc_ky': txtHocKy,
      'txt_class_name': txtClassName,
      'status_note': statusNote,
    };
  }

  factory ScoreModel.fromJson(String source) =>
      ScoreModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
  DateFormat formatDateDrill = DateFormat('dd-MM-yyyy', 'vi_VN');

  String getInitTime() {
    return formatDateDrill.format(DateTime.now());
  }

  factory ScoreModel.empty() => ScoreModel(
        txtDiem: TxtDiemMoetType.empty(),
        txtLearnYear: '',
        txtHocKy: '',
        txtClassName: '',
        statusNote: '',
      );

  factory ScoreModel.fakeData() => ScoreModel(
        txtDiem: TxtDiemMoetType.fakeData(),
        txtLearnYear: '2021-2022',
        txtHocKy: '1',
        txtClassName: 'Lớp 1A',
        statusNote: 'MOET',
      );
}

class TxtDiemMoetType {
  final List<ScoreDataType>? scoreData;
  final List<DiemDataType>? diemData;
  final String? kqht;
  final String? kqrl;
  final String? hocKy;
  final String? dtbCn;
  final String? xlhlCn;
  final String? xlhkCn;
  final String? danhHieuCn;
  final String? ngayNghiCn;
  final String? nhanXetGvcnCn;
  final String? nhanXetChungCuaGvcn;

  TxtDiemMoetType({
    this.scoreData,
    this.diemData,
    this.kqht,
    this.kqrl,
    this.hocKy,
    this.dtbCn,
    this.xlhlCn,
    this.xlhkCn,
    this.danhHieuCn,
    this.ngayNghiCn,
    this.nhanXetGvcnCn,
    this.nhanXetChungCuaGvcn,
  });
  factory TxtDiemMoetType.fromMap(Map<String, dynamic> map) {
    return TxtDiemMoetType(
      scoreData: map['score_data'] == null
          ? null
          : List<ScoreDataType>.from(
              (map['score_data'] as List<dynamic>).map(
                (item) => ScoreDataType.fromMap(item as Map<String, dynamic>),
              ),
            ),
      diemData: map['diem_data'] == null
          ? null
          : List<DiemDataType>.from(
              (map['diem_data'] as List<dynamic>).map(
                (item) => DiemDataType.fromMap(item as Map<String, dynamic>),
              ),
            ),
      kqht: map['kqht']?.toString(),
      kqrl: map['kqrl']?.toString(),
      hocKy: map['hoc_ky']?.toString(),
      dtbCn: map['dtb_cn']?.toString(),
      xlhlCn: map['xlhl_cn']?.toString(),
      xlhkCn: map['xlhk_cn']?.toString(),
      danhHieuCn: map['danhhieu_cn']?.toString(),
      ngayNghiCn: map['ngay_nghi_cn']?.toString(),
      nhanXetGvcnCn: map['nhan_xet_gvcn_cn']?.toString(),
      nhanXetChungCuaGvcn: map['nhan_xet_chung_cua_gvcn']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'score_data': scoreData != null
          ? List<dynamic>.from(
              scoreData!.map(
                (x) => x.toMap(),
              ),
            )
          : [],
      'diem_data': diemData != null
          ? List<dynamic>.from(
              diemData!.map(
                (x) => x.toMap(),
              ),
            )
          : [],
      'kqht': kqht,
      'kqrl': kqrl,
      'hoc_ky': hocKy,
      'dtb_cn': dtbCn,
      'xlhl_cn': xlhlCn,
      'xlhk_cn': xlhkCn,
      'danhhieu_cn': danhHieuCn,
      'ngay_nghi_cn': ngayNghiCn,
      'nhan_xet_gvcn_cn': nhanXetGvcnCn,
      'nhan_xet_chung_cua_gvcn': nhanXetChungCuaGvcn,
    };
  }

  factory TxtDiemMoetType.empty() => TxtDiemMoetType(
        scoreData: [],
        diemData: [],
        kqht: null,
        kqrl: null,
        hocKy: null,
        dtbCn: null,
        xlhlCn: null,
        xlhkCn: null,
        danhHieuCn: null,
        ngayNghiCn: null,
        nhanXetGvcnCn: null,
        nhanXetChungCuaGvcn: null,
      );

  factory TxtDiemMoetType.fakeData() => TxtDiemMoetType(
        scoreData: List.generate(
          10,
          (index) => ScoreDataType(
            subjectId: 'subjectId$index',
            subjectName: 'subjectName$index',
            ddgtx: List.generate(5, (index) => 'ddgtx$index'),
            ddggk: 'ddggk$index',
            ddgck: 'ddgck$index',
            tbmhk: 'tbmhk$index',
          ),
        ),
      );

  factory TxtDiemMoetType.fromJson(String source) =>
      TxtDiemMoetType.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

class ScoreDataType {
  final String subjectId;
  final String subjectName;
  final List<String>? ddgtx;
  final String? ddggk;
  final String? ddgck;
  final String? tbmhk;

  ScoreDataType({
    required this.subjectId,
    required this.subjectName,
    this.ddgtx,
    this.ddggk,
    this.ddgck,
    this.tbmhk,
  });
  factory ScoreDataType.fromMap(Map<String, dynamic> map) {
    return ScoreDataType(
      subjectId: map['SUBJECT_ID'],
      subjectName: map['SUBJECT_NAME'],
      ddgtx: map['ddgtx'] == null
          ? []
          : List<String>.from(map['ddgtx'].cast<String>()),
      ddggk: map['ddggk']?.toString(),
      ddgck: map['ddgck']?.toString(),
      tbmhk: map['tbmhk']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SUBJECT_ID': subjectId,
      'SUBJECT_NAME': subjectName,
      'ddgtx': ddgtx,
      'ddggk': ddggk,
      'ddgck': ddgck,
      'tbmhk': tbmhk,
    };
  }

  factory ScoreDataType.fromJson(String source) =>
      ScoreDataType.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ExerciseItem( subjectId: $subjectId, subjectName: $subjectName, ddgtx: $ddgtx, ddggk: $ddggk, ddgck: $ddgck, tbmhk: $tbmhk)';
}

class DiemDataType {
  final String subjectId;
  final String subjectName;
  final DiemItemType? diemGiuaHk1;
  final DiemItemType? diemCuoiHk1;
  final DiemItemType? diemGiuaHk2;
  final DiemItemType? diemCuoiNam;

  DiemDataType({
    required this.subjectId,
    required this.subjectName,
    this.diemGiuaHk1,
    this.diemCuoiHk1,
    this.diemGiuaHk2,
    this.diemCuoiNam,
  });
  factory DiemDataType.fromMap(Map<String, dynamic> map) {
    return DiemDataType(
      subjectId: map['subject_id'],
      subjectName: map['subject_name'],
      diemGiuaHk1: map['diem_giua_hk1'] == null
          ? DiemItemType.empty()
          : DiemItemType.fromMap(map['diem_giua_hk1']),
      diemCuoiHk1: map['diem_cuoi_hk1'] == null
          ? DiemItemType.empty()
          : DiemItemType.fromMap(map['diem_cuoi_hk1']),
      diemGiuaHk2: map['diem_giua_hk2'] == null
          ? DiemItemType.empty()
          : DiemItemType.fromMap(map['diem_giua_hk2']),
      diemCuoiNam: map['diem_cuoi_nam'] == null
          ? DiemItemType.empty()
          : DiemItemType.fromMap(map['diem_cuoi_nam']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SUBJECT_ID': subjectId,
      'SUBJECT_NAME': subjectName,
      'ddgtx': diemGiuaHk1,
      'ddggk': diemCuoiHk1,
      'ddgck': diemGiuaHk2,
      'tbmhk': diemCuoiNam,
    };
  }

  factory DiemDataType.fromJson(String source) =>
      DiemDataType.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ExerciseItem( subjectId: $subjectId, subjectName: $subjectName, diemGiuaHk1: $diemGiuaHk1, diemCuoiHk1: $diemCuoiHk1, diemGiuaHk2: $diemGiuaHk2, diemCuoiNam: $diemCuoiNam)';
}

class DiemItemType {
  final String? mucDatDuoc;
  final String? diemKtdk;
  final String? nhanXet;

  DiemItemType({this.mucDatDuoc, this.diemKtdk, this.nhanXet});

  factory DiemItemType.fromMap(Map<String, dynamic> map) {
    return DiemItemType(
      mucDatDuoc: map['muc_dat_duoc'] ?? '',
      diemKtdk: map['diem_ktdk'] ?? '',
      nhanXet: map['nhan_xet'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'muc_dat_duoc': mucDatDuoc,
      'diem_ktdk': diemKtdk,
      'nhan_xet': nhanXet,
    };
  }

  factory DiemItemType.fromJson(String source) =>
      DiemItemType.fromMap(json.decode(source));

  factory DiemItemType.empty() =>
      DiemItemType(mucDatDuoc: '', diemKtdk: '', nhanXet: '');

  String toJson() => json.encode(toMap());
}

class TbmhkType {
  final String? stringValue;
  final double? doubleValue;

  TbmhkType.fromString(this.stringValue) : doubleValue = null;
  TbmhkType.fromDouble(this.doubleValue) : stringValue = null;

  @override
  String toString() {
    return stringValue ?? doubleValue.toString();
  }
}
