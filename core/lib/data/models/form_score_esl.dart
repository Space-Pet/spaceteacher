class FormScoreESL {
  int pupilId;
  String pupilName;
  ScoreImageESL pupilImage;
  String classId;
  String subjectId;
  String semester;
  String learnYear;
  List<ScoreFieldESL> fields;

  FormScoreESL({
    required this.pupilId,
    required this.pupilName,
    required this.pupilImage,
    required this.classId,
    required this.subjectId,
    required this.semester,
    required this.learnYear,
    required this.fields,
  });

  factory FormScoreESL.fromJson(Map<String, dynamic> json) {
    var list = json['fields'] as List;
    List<ScoreFieldESL> fieldsList =
        list.map((i) => ScoreFieldESL.fromJson(i)).toList();

    return FormScoreESL(
      pupilId: json['pupil_id'],
      pupilName: json['pupil_name'],
      pupilImage: ScoreImageESL.fromJson(json['pupil_image']),
      classId: json['class_id'],
      subjectId: json['subject_id'],
      semester: json['semester'],
      learnYear: json['learn_year'],
      fields: fieldsList,
    );
  }

  // Method to return an empty instance
  factory FormScoreESL.empty() {
    return FormScoreESL(
      pupilId: 0,
      pupilName: '',
      pupilImage: ScoreImageESL.empty(),
      classId: '',
      subjectId: '',
      semester: '',
      learnYear: '',
      fields: [],
    );
  }

  // Method to return a list of fake data instances
  static List<FormScoreESL> fakeData() {
    return List.generate(
      20,
      (index) => FormScoreESL(
        pupilId: 1,
        pupilName: '',
        pupilImage: ScoreImageESL.fakeData(),
        classId: 'Class A',
        subjectId: 'Math',
        semester: '1',
        learnYear: '2023-2024',
        fields: ScoreFieldESL.fakeData(),
      ),
    );
  }
}

class ScoreImageESL {
  String web;
  String mobile;

  ScoreImageESL({required this.web, required this.mobile});

  factory ScoreImageESL.fromJson(Map<String, dynamic> json) {
    return ScoreImageESL(
      web: json['web'],
      mobile: json['mobile'],
    );
  }

  // Method to return an empty instance
  factory ScoreImageESL.empty() {
    return ScoreImageESL(
      web: '',
      mobile: '',
    );
  }

  // Method to return a fake data instance
  static ScoreImageESL fakeData() {
    return ScoreImageESL(
      web: 'https://example.com/web.jpg',
      mobile: 'https://example.com/mobile.jpg',
    );
  }
}

class ScoreFieldESL {
  int id;
  String label;
  String scoreType;
  dynamic key;
  String? inputValue;

  ScoreFieldESL({
    required this.id,
    required this.label,
    required this.scoreType,
    required this.key,
    required this.inputValue,
  });

  factory ScoreFieldESL.fromJson(Map<String, dynamic> json) {
    return ScoreFieldESL(
      id: json['id'] != null ? json['id'] : 0,
      label: json['label'],
      scoreType: json['score_type'],
      key: json['key'],
      inputValue: json['input_value'],
    );
  }

  // Method to return an empty instance
  factory ScoreFieldESL.empty() {
    return ScoreFieldESL(
      id: 0,
      label: '',
      scoreType: '',
      key: 0,
      inputValue: '',
    );
  }

  // Method to return a list of fake data instances
  static List<ScoreFieldESL> fakeData() {
    return [
      ScoreFieldESL(
        id: 1,
        label: '',
        scoreType: '',
        key: 101,
        inputValue: '',
      ),
      // Add more instances as needed
    ];
  }
}
