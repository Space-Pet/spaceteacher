import 'dart:convert';

class EslScore {
  String pupilId;
  String hocKy;
  String learnYear;
  List<EslScoreData> data;

  EslScore({
    required this.pupilId,
    required this.hocKy,
    required this.learnYear,
    required this.data,
  });

  factory EslScore.fromMap(Map<String, dynamic> map) {
    return EslScore(
      pupilId: map['pupil_id'],
      hocKy: map['txt_hoc_ky'],
      learnYear: map['txt_learn_year'],
      data: List<EslScoreData>.from(
        map['data']?.map((x) => EslScoreData.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pupil_id': pupilId,
      'txt_hoc_ky': hocKy,
      'txt_learn_year': learnYear,
      'data': List<dynamic>.from(data.map((x) => x.toMap())),
    };
  }

  factory EslScore.fromJson(String source) =>
      EslScore.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory EslScore.empty() => EslScore(
        pupilId: '',
        hocKy: '',
        learnYear: '',
        data: [],
      );

  @override
  String toString() {
    return 'EslScore(pupilId: $pupilId, hocKy: $hocKy, learnYear: $learnYear, data: $data)';
  }
}

class EslScoreData {
  String markEslType;
  SubjectEsl subjectEsl;
  SubjectEslCore subjectEslCore;

  EslScoreData({
    required this.markEslType,
    required this.subjectEsl,
    required this.subjectEslCore,
  });

  factory EslScoreData.fromMap(Map<String, dynamic> map) {
    return EslScoreData(
      markEslType: map['MARK_ESL_TYPE'],
      subjectEsl: SubjectEsl.fromMap(map['SUBJECT_ESL']),
      subjectEslCore: SubjectEslCore.fromMap(map['SUBJECT_ESL_CORE']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'MARK_ESL_TYPE': markEslType,
      'SUBJECT_ESL': subjectEsl.toMap(),
      'SUBJECT_ESL_CORE': subjectEslCore.toMap(),
    };
  }
}

class SubjectEsl {
  String? subjectEslId;
  String? subjectEslName;

  SubjectEsl({
    this.subjectEslId,
    this.subjectEslName,
  });

  factory SubjectEsl.fromMap(Map<String, dynamic> map) {
    return SubjectEsl(
      subjectEslId: map['SUBJECT_ESL_ID'],
      subjectEslName: map['SUBJECT_ESL_NAME'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SUBJECT_ESL_ID': subjectEslId,
      'SUBJECT_ESL_NAME': subjectEslName,
    };
  }
}

class SubjectEslCore {
  String? subjectEslCoreId;
  String? subjectEslCoreName;
  String? subjectEslCoreValue;
  String? subjectEslComment;

  SubjectEslCore({
    this.subjectEslCoreId,
    this.subjectEslCoreName,
    this.subjectEslCoreValue,
    this.subjectEslComment,
  });

  factory SubjectEslCore.fromMap(Map<String, dynamic> map) {
    return SubjectEslCore(
      subjectEslCoreId: map['SUBJECT_ESL_CORE_ID'],
      subjectEslCoreName: map['SUBJECT_ESL_CORE_NAME'],
      subjectEslCoreValue: map['SUBJECT_ESL_CORE_VALUE'],
      subjectEslComment: map['SUBJECT_ESL_COMMENT'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'SUBJECT_ESL_CORE_ID': subjectEslCoreId,
      'SUBJECT_ESL_CORE_NAME': subjectEslCoreName,
      'SUBJECT_ESL_CORE_VALUE': subjectEslCoreValue,
      'SUBJECT_ESL_COMMENT': subjectEslComment,
    };
  }
}
