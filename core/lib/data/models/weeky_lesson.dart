import 'dart:convert';

class WeeklyLessonData {
  final List<LessonData> lessonDataList;

  WeeklyLessonData({required this.lessonDataList});

  factory WeeklyLessonData.fromMap(Map<String, dynamic> map) {
    if (map['weeklylesson_data'] == null) {
      return WeeklyLessonData(lessonDataList: []);
    }

    return WeeklyLessonData(
      lessonDataList: List<LessonData>.from(
        map['weeklylesson_data']?.map(
          LessonData.fromMap,
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weeklylesson_data': List<dynamic>.from(
        lessonDataList.map(
          (x) => x.toMap(),
        ),
      ),
    };
  }

  factory WeeklyLessonData.fromJson(String source) =>
      WeeklyLessonData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'WeeklyLessonData(lessonDataList: $lessonDataList)';
}

class LessonData {
  final Ngay ngay;
  final List<LessonDataItem> dataList;

  LessonData({required this.ngay, required this.dataList});

  factory LessonData.fromMap(Map<String, dynamic> map) {
    return LessonData(
      ngay: Ngay.fromMap(map['Ngay']),
      dataList: List<LessonDataItem>.from(
        map['Data']?.map(
          LessonDataItem.fromMap,
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Ngay': ngay.toMap(),
      'Data': List<dynamic>.from(
        dataList.map(
          (x) => x.toMap(),
        ),
      ),
    };
  }

  factory LessonData.fromJson(String source) =>
      LessonData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory LessonData.empty() => LessonData(ngay: Ngay.empty(), dataList: []);

  @override
  String toString() => 'LessonData(ngay: $ngay, dataList: $dataList)';
}

class Ngay {
  final int date;
  final String dateName;
  final String day;

  Ngay({required this.date, required this.dateName, required this.day});

  factory Ngay.fromMap(Map<String, dynamic> map) {
    return Ngay(
      date: map['Date'],
      dateName: map['Date_Name'],
      day: map['Day'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Date': date,
      'Date_Name': dateName,
      'Day': day,
    };
  }

  factory Ngay.fromJson(String source) => Ngay.fromMap(json.decode(source));

  factory Ngay.empty() => Ngay(date: 0, dateName: '', day: '');

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Ngay(date: $date, dateName: $dateName, day: $day)';
}

class LessonDataItem {
  final String lessonId;
  final String? lessonName;
  final String subjectId;
  final String subjectName;
  final String? lessonNote;
  final String? danDoBaoBai;
  final String? fileBaoBai;
  final String? fileBaoBaiDomain;
  final String? linkBaoBai;
  final String? hanNopBaoBai;
  final String teacherId;
  final String teacherName;
  final String teacherImg;
  final String tietNum;
  final String tietStatus;
  final String tietStatusNote;
  final List<LessonRank> lessonRank;

  LessonDataItem({
    required this.lessonId,
    this.lessonName,
    required this.subjectId,
    required this.subjectName,
    this.lessonNote,
    this.danDoBaoBai,
    this.fileBaoBai,
    this.fileBaoBaiDomain,
    this.linkBaoBai,
    this.hanNopBaoBai,
    required this.teacherId,
    required this.teacherName,
    required this.teacherImg,
    required this.tietNum,
    required this.tietStatus,
    required this.tietStatusNote,
    required this.lessonRank,
  });

  factory LessonDataItem.fromMap(Map<String, dynamic> map) {
    return LessonDataItem(
      lessonId: map['lesson_id'],
      lessonName: map['lesson_name'],
      subjectId: map['subject_id'],
      subjectName: map['subject_name'],
      lessonNote: map['lesson_note'],
      danDoBaoBai: map['dan_do_bao_bai'],
      fileBaoBai: map['file_bao_bai'],
      fileBaoBaiDomain: map['file_bao_bai_domain'],
      linkBaoBai: map['link_bao_bai'],
      hanNopBaoBai: map['han_nop_bao_bai'],
      teacherId: map['teacher_id'],
      teacherName: map['teacher_name'],
      teacherImg: map['teacher_img'],
      tietNum: map['tiet_num'],
      tietStatus: map['tiet_status'],
      tietStatusNote: map['tiet_status_note'],
      lessonRank: List<LessonRank>.from(
        map['lesson_rank']?.map(
          LessonRank.fromMap,
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lesson_id': lessonId,
      'lesson_name': lessonName,
      'subject_id': subjectId,
      'subject_name': subjectName,
      'lesson_note': lessonNote,
      'dan_do_bao_bai': danDoBaoBai,
      'file_bao_bai': fileBaoBai,
      'file_bao_bai_domain': fileBaoBaiDomain,
      'link_bao_bai': linkBaoBai,
      'han_nop_bao_bai': hanNopBaoBai,
      'teacher_id': teacherId,
      'teacher_name': teacherName,
      'teacher_img': teacherImg,
      'tiet_num': tietNum,
      'tiet_status': tietStatus,
      'tiet_status_note': tietStatusNote,
      'lesson_rank': List<dynamic>.from(
        lessonRank.map(
          (x) => x.toMap(),
        ),
      ),
    };
  }

  factory LessonDataItem.fromJson(String source) =>
      LessonDataItem.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Data(lessonId: $lessonId, lessonName: $lessonName, subjectId: $subjectId, subjectName: $subjectName, lessonNote: $lessonNote, danDoBaoBai: $danDoBaoBai, fileBaoBai: $fileBaoBai, fileBaoBaiDomain: $fileBaoBaiDomain, linkBaoBai: $linkBaoBai, hanNopBaoBai: $hanNopBaoBai, teacherId: $teacherId, teacherName: $teacherName, teacherImg: $teacherImg, tietNum: $tietNum, tietStatus: $tietStatus, tietStatusNote: $tietStatusNote, lessonRank: $lessonRank)';
}

class LessonRank {
  final int lessonRankKey;
  final String lessonRankName;
  final int active;

  LessonRank({
    required this.lessonRankKey,
    required this.lessonRankName,
    required this.active,
  });

  factory LessonRank.fromMap(Map<String, dynamic> map) {
    return LessonRank(
      lessonRankKey: map['lesson_rank_key'],
      lessonRankName: map['lesson_rank_name'],
      active: map['active'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lesson_rank_key': lessonRankKey,
      'lesson_rank_name': lessonRankName,
      'active': active,
    };
  }

  factory LessonRank.fromJson(String source) =>
      LessonRank.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'LessonRank(lessonRankKey: $lessonRankKey, lessonRankName: $lessonRankName, active: $active)';
}
