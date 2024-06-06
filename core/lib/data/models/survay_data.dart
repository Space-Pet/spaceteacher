import 'dart:convert';

class Survey {
  final int khaoSatId;
  final String name;
  int status;
  String statusText;
  String learnYear;
  int? hocKy;

  Survey({
    required this.khaoSatId,
    required this.name,
    required this.status,
    required this.statusText,
    required this.learnYear,
    this.hocKy,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      khaoSatId: json['khao_sat_id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? 0,
      statusText: json['status_text'] ?? '',
      learnYear: json['learn_year'] ?? '',
      hocKy: json['hoc_ky'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'khao_sat_id': khaoSatId,
      'name': name,
      'status': status,
      'status_text': statusText,
      'learn_year': learnYear,
      'hoc_ky': hocKy,
    };
  }
}

class SurveyDetail {
  final SurveyInfo info;
  final List<SurveyQuestion> questions;

  SurveyDetail({
    required this.info,
    required this.questions,
  });

  factory SurveyDetail.fromMap(Map<String, dynamic> map) {
    return SurveyDetail(
      info: SurveyInfo.fromMap(map['info']),
      questions: List<SurveyQuestion>.from(
        map['questions'].map(SurveyQuestion.fromMap),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'info': info.toMap(),
      'questions': List<dynamic>.from(questions.map((x) => x.toMap())),
    };
  }

  factory SurveyDetail.fromJson(String source) =>
      SurveyDetail.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory SurveyDetail.empty() {
    return SurveyDetail(
      info: SurveyInfo.empty(),
      questions: [],
    );
  }
}

class SurveyInfo {
  final int khaoSatId;
  final String name;
  final String gioiThieu;

  SurveyInfo({
    required this.khaoSatId,
    required this.name,
    required this.gioiThieu,
  });

  factory SurveyInfo.fromMap(Map<String, dynamic> map) {
    return SurveyInfo(
      khaoSatId: map['khao_sat_id'],
      name: map['name'],
      gioiThieu: map['gioi_thieu'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'khao_sat_id': khaoSatId,
      'name': name,
      'gioi_thieu': gioiThieu,
    };
  }

  factory SurveyInfo.empty() {
    return SurveyInfo(
      khaoSatId: 0,
      name: '',
      gioiThieu: '',
    );
  }
}

class SurveyQuestion {
  final String nhomCauHoi;
  final List<CauHoi> cauHoi;

  SurveyQuestion({
    required this.nhomCauHoi,
    required this.cauHoi,
  });

  factory SurveyQuestion.fromMap(Map<String, dynamic> map) {
    return SurveyQuestion(
      nhomCauHoi: map['NHOM_CAU_HOI'],
      cauHoi: List<CauHoi>.from(map['Cau_Hoi'].map(CauHoi.fromMap)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'NHOM_CAU_HOI': nhomCauHoi,
      'Cau_Hoi': List<dynamic>.from(cauHoi.map((x) => x.toMap())),
    };
  }
}

class CauHoi {
  final int cauHoiId;
  final String noiDungCauHoi;
  final Level? mucDoHaiLong;
  final String? traLoiKhac;
  final String loaiCauHoi;

  CauHoi({
    required this.cauHoiId,
    required this.noiDungCauHoi,
    this.mucDoHaiLong,
    this.traLoiKhac,
    required this.loaiCauHoi,
  });

  factory CauHoi.fromMap(Map<String, dynamic> map) {
    return CauHoi(
      cauHoiId: map['CAU_HOI_ID'],
      noiDungCauHoi: map['NOI_DUNG_CAU_HOI'],
      mucDoHaiLong: map['MUC_DO_HAI_LONG'] != null
          ? Level.fromMap(map['MUC_DO_HAI_LONG'])
          : null,
      traLoiKhac: map['TRA_LOI_KHAC'],
      loaiCauHoi: map['LOAI_CAU_HOI'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'CAU_HOI_ID': cauHoiId,
      'NOI_DUNG_CAU_HOI': noiDungCauHoi,
      'MUC_DO_HAI_LONG': mucDoHaiLong?.toMap(),
      'TRA_LOI_KHAC': traLoiKhac,
      'LOAI_CAU_HOI': loaiCauHoi,
    };
  }
}

class Level {
  final int veryPleased;
  final int pleased;
  final int normal;
  final int unsatisfied;
  final int dissatisfaction;

  Level({
    required this.veryPleased,
    required this.pleased,
    required this.normal,
    required this.unsatisfied,
    required this.dissatisfaction,
  });

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      veryPleased: map['Rất hài lòng'],
      pleased: map['Hài lòng'],
      normal: map['Bình thường'],
      unsatisfied: map['Không hài lòng'],
      dissatisfaction: map['Rất không hài lòng'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Rất hài lòng': veryPleased,
      'Hài lòng': pleased,
      'Bình thường': normal,
      'Không hài lòng': unsatisfied,
      'Rất không hài lòng': dissatisfaction,
    };
  }
}
