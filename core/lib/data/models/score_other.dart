import 'dart:convert';

class ScoreOther {
  final String pupilId;
  final String txtLearnYear;
  final String status;
  final String statusNote;
  final List<ScoreOtherData>? data;

  ScoreOther({
    required this.pupilId,
    required this.txtLearnYear,
    required this.status,
    required this.statusNote,
    this.data,
  });

  factory ScoreOther.fromMap(Map<String, dynamic> map) {
    print(map);
    return ScoreOther(
      pupilId: map['pupil_id'],
      txtLearnYear: map['txt_learn_year'],
      status: map['status'],
      statusNote: map['status_note'],
      data: List<ScoreOtherData>.from(
        map['data']?.map((x) => ScoreOtherData.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pupil_id': pupilId,
      'txt_learn_year': txtLearnYear,
      'status': status,
      'status_note': statusNote,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ScoreOther.fromJson(String source) =>
      ScoreOther.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory ScoreOther.empty() => ScoreOther(
        pupilId: '',
        txtLearnYear: '',
        status: '',
        statusNote: '',
        data: [],
      );
}

class ScoreOtherData {
  final String ctId;
  final String ctName;
  final String schoolId;
  final String schoolName;

  ScoreOtherData({
    required this.ctId,
    required this.ctName,
    required this.schoolId,
    required this.schoolName,
  });

  factory ScoreOtherData.fromMap(Map<String, dynamic> map) {
    return ScoreOtherData(
      ctId: map['CT_ID'],
      ctName: map['CT_NAME'],
      schoolId: map['SCHOOL_ID'],
      schoolName: map['SCHOOL_NAME'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'CT_ID': ctId,
      'CT_NAME': ctName,
      'SCHOOL_ID': schoolId,
      'SCHOOL_NAME': schoolName,
    };
  }
}
