class MoetHigh {
  final String status;
  final String message;
  final int code;
  final MoetHighData data;

  MoetHigh({
    required this.status,
    required this.message,
    required this.code,
    required this.data,
  });

  factory MoetHigh.fromJson(Map<String, dynamic> json) {
    return MoetHigh(
      status: json['status'],
      message: json['message'],
      code: json['code'],
      data: MoetHighData.fromJson(json['data']),
    );
  }

  factory MoetHigh.empty() => MoetHigh(
        status: '',
        message: '',
        code: 0,
        data: MoetHighData.empty(),
      );

  static List<MoetHigh> fakeData() {
    return List.generate(
      10,
      (index) => MoetHigh(
        status: 'success',
        message: 'Message $index',
        code: 200,
        data: MoetHighData.fakeData(),
      ),
    );
  }
}

class MoetHighData {
  final MoetHighSubject subject;
  final String semester;
  final String learnYear;
  final List<MoetHighScoreData> scoreData;

  MoetHighData({
    required this.subject,
    required this.semester,
    required this.learnYear,
    required this.scoreData,
  });

  factory MoetHighData.fromJson(Map<String, dynamic> json) {
    var list = json['score_data'] as List;
    List<MoetHighScoreData> scoreDataList =
        list.map((i) => MoetHighScoreData.fromJson(i)).toList();

    return MoetHighData(
      subject: MoetHighSubject.fromJson(json['subject']),
      semester: json['semester'],
      learnYear: json['learn_year'],
      scoreData: scoreDataList,
    );
  }

  factory MoetHighData.empty() => MoetHighData(
        subject: MoetHighSubject.empty(),
        semester: '',
        learnYear: '',
        scoreData: [],
      );

  static MoetHighData fakeData() {
    return MoetHighData(
      subject: MoetHighSubject.fakeData(),
      semester: '2',
      learnYear: '2023-2024',
      scoreData: MoetHighScoreData.fakeData(),
    );
  }
}

class MoetHighSubject {
  final int subjectId;
  final String subjectName;

  MoetHighSubject({
    required this.subjectId,
    required this.subjectName,
  });

  factory MoetHighSubject.fromJson(Map<String, dynamic> json) {
    return MoetHighSubject(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
    );
  }

  factory MoetHighSubject.empty() => MoetHighSubject(
        subjectId: 0,
        subjectName: '',
      );

  static MoetHighSubject fakeData() {
    return MoetHighSubject(
      subjectId: 67,
      subjectName: 'HĐ trải nghiệm, hướng nghiệp',
    );
  }
}

class MoetHighScoreData {
  final int pupilId;
  final String pupilName;
  final MoetHighScore score;
  final double averageScore;
  final String? comment;

  MoetHighScoreData({
    required this.pupilId,
    required this.pupilName,
    required this.score,
    required this.averageScore,
    required this.comment,
  });

  factory MoetHighScoreData.fromJson(Map<String, dynamic> json) {
    double averageScore;
    if (json['average_score'] is int) {
      averageScore = (json['average_score'] as int).toDouble();
    } else {
      averageScore = json['average_score'];
    }
    return MoetHighScoreData(
      pupilId: json['pupil_id'],
      pupilName: json['pupil_name'],
      score: MoetHighScore.fromJson(json['score']),
      averageScore: averageScore,
      comment: json['comment'] ?? '',
    );
  }

  factory MoetHighScoreData.empty() => MoetHighScoreData(
        pupilId: 0,
        pupilName: '',
        score: MoetHighScore.empty(),
        averageScore: 0.0,
        comment: '',
      );

  static List<MoetHighScoreData> fakeData() {
    return List.generate(
      10,
      (index) => MoetHighScoreData(
        pupilId: index,
        pupilName: 'Pupil Name $index',
        score: MoetHighScore.fakeData(),
        averageScore: (index + 6.0),
        comment: 'Comment $index',
      ),
    );
  }
}

class MoetHighScore {
  final List<String>? ddgtx;
  final List<String>? ddggk;
  final List<String>? ddgck;

  MoetHighScore({
    required this.ddgtx,
    required this.ddggk,
    required this.ddgck,
  });

  factory MoetHighScore.fromJson(Map<String, dynamic> json) {
    return MoetHighScore(
      ddgtx: List<String>.from(json['ddgtx']),
      ddggk: List<String>.from(json['ddggk']),
      ddgck: List<String>.from(json['ddgck']),
    );
  }

  factory MoetHighScore.empty() => MoetHighScore(
        ddgtx: [],
        ddggk: [],
        ddgck: [],
      );

  static MoetHighScore fakeData() {
    return MoetHighScore(
      ddgtx: ['7.0', '5.0'],
      ddggk: ['6.8'],
      ddgck: [],
    );
  }
}
