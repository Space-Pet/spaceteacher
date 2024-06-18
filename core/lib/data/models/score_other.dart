import 'dart:convert';


class ScoreProgramList {
  String pupilId;
  String txtLearnYear;
  String status;
  String statusNote;
  List<ScoreProgram> data;

  ScoreProgramList({
    required this.pupilId,
    required this.txtLearnYear,
    required this.status,
    required this.statusNote,
    required this.data,
  });

  factory ScoreProgramList.fromMap(Map<String, dynamic> map) {
    var data = map['data'];
    if (data == null || data.isEmpty) {
      data = [];
    } else {
      data = List<ScoreProgram>.from(
        map['data'].map((dynamic item) =>
            ScoreProgram.fromMap(item as Map<String, dynamic>)),
      );
    }

    return ScoreProgramList(
      pupilId: map['pupil_id'],
      txtLearnYear: map['txt_learn_year'],
      status: map['status'],
      statusNote: map['status_note'],
      data: data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pupil_id': pupilId,
      'txt_learn_year': txtLearnYear,
      'status': status,
      'status_note': statusNote,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory ScoreProgramList.fromJson(String source) =>
      ScoreProgramList.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  factory ScoreProgramList.empty() => ScoreProgramList(
        pupilId: '',
        txtLearnYear: '',
        status: '',
        statusNote: '',
        data: [],
      );
}

class ScoreProgram {
  final String ctId;
  final String ctName;
  final String schoolId;
  final String schoolName;

  ScoreProgram({
    required this.ctId,
    required this.ctName,
    required this.schoolId,
    required this.schoolName,
  });

  factory ScoreProgram.fromMap(Map<String, dynamic> map) {
    return ScoreProgram(
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

  factory ScoreProgram.empty() => ScoreProgram(
        ctId: '',
        ctName: '',
        schoolId: '',
        schoolName: '',
      );
}
