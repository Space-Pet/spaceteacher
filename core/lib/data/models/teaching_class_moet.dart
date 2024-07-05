class TeachingClassMoet {
  final String status;
  final String message;
  final int code;
  final Data data;

  TeachingClassMoet({
    required this.status,
    required this.message,
    required this.code,
    required this.data,
  });

  factory TeachingClassMoet.fromJson(Map<String, dynamic> json) {
    return TeachingClassMoet(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      data: Data.fromJson(json['data']),
    );
  }

  factory TeachingClassMoet.empty() => TeachingClassMoet(
        status: '',
        message: '',
        code: 0,
        data: Data.empty(),
      );

  static List<TeachingClassMoet> fakeData() {
    return List.generate(
      10,
      (index) => TeachingClassMoet(
        status: 'success',
        message: 'Message $index',
        code: 200,
        data: Data.fakeData(),
      ),
    );
  }
}

class Data {
  final Subject subject;
  final String semester;
  final String learnYear;
  final List<ScoreDataMoet> scoreData;

  Data({
    required this.subject,
    required this.semester,
    required this.learnYear,
    required this.scoreData,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['score_data'] as List;
    List<ScoreDataMoet> scoreDataList =
        list.map((i) => ScoreDataMoet.fromJson(i)).toList();

    return Data(
      subject: Subject.fromJson(json['subject']),
      semester: json['semester'],
      learnYear: json['learn_year'],
      scoreData: scoreDataList,
    );
  }

  factory Data.empty() => Data(
        subject: Subject.empty(),
        semester: '',
        learnYear: '',
        scoreData: [],
      );

  static Data fakeData() {
    return Data(
      subject: Subject.fakeData(),
      semester: '2',
      learnYear: '2023-2024',
      scoreData: ScoreDataMoet.fakeData(),
    );
  }
}

class Subject {
  final int subjectId;
  final String subjectName;

  Subject({
    required this.subjectId,
    required this.subjectName,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
    );
  }

  factory Subject.empty() => Subject(
        subjectId: 0,
        subjectName: '',
      );

  static Subject fakeData() {
    return Subject(
      subjectId: 67,
      subjectName: 'HĐ trải nghiệm, hướng nghiệp',
    );
  }
}

class ScoreDataMoet {
  final int pupilId;
  final String pupilName;
  final Score score;
  final String? comment;

  ScoreDataMoet({
    required this.pupilId,
    required this.pupilName,
    required this.score,
    required this.comment,
  });

  factory ScoreDataMoet.fromJson(Map<String, dynamic> json) {
    return ScoreDataMoet(
      pupilId: json['pupil_id'],
      pupilName: json['pupil_name'],
      score: Score.fromJson(json['score']),
      comment: json['comment'] ?? '',
    );
  }

  factory ScoreDataMoet.empty() => ScoreDataMoet(
        pupilId: 0,
        pupilName: '',
        score: Score.empty(),
        comment: '',
      );

  static List<ScoreDataMoet> fakeData() {
    return List.generate(
      10,
      (index) => ScoreDataMoet(
        pupilId: index,
        pupilName: 'Pupil Name $index',
        score: Score.fakeData(),
        comment: 'Comment $index',
      ),
    );
  }
}

class Score {
  final String value;
  final String text;

  Score({
    required this.value,
    required this.text,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      value: json['value'],
      text: json['text'],
    );
  }

  factory Score.empty() => Score(
        value: '',
        text: '',
      );

  static Score fakeData() {
    return Score(
      value: 'T',
      text: 'Hoàn thành tốt(T)',
    );
  }
}
