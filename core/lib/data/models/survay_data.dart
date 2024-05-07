class SurveyData {
  final String nhomCauHoi;
  final List<Question> question;
  const SurveyData({required this.nhomCauHoi, required this.question});
  factory SurveyData.fromJson(Map<String, dynamic> json) {
    return SurveyData(
        nhomCauHoi: json['NHOM_CAU_HOI'] ?? '',
        question: List<Question>.from(
            json['Cau_Hoi'].map((e) => Question.fromJson(e))));
  }
}

class Question {
  final int cauHoiId;
  final String noiDungCauHoi;
  final Level? level;
  const Question({
    required this.cauHoiId,
    this.level,
    required this.noiDungCauHoi,
  });
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      cauHoiId: json['CAU_HOI_ID'] ?? 0,
      noiDungCauHoi: json['NOI_DUNG_CAU_HOI'] ?? '',
      level: json['MUC_DO_HAI_LONG'] != null
          ? Level.fromJson(json['MUC_DO_HAI_LONG'])
          : null,
    );
  }
}

class Level {
  final int veryPleased;
  final int pleased;
  final int normal;
  final int unsatisfied;
  final int dissatisfaction;
  const Level(
      {required this.dissatisfaction,
      required this.normal,
      required this.pleased,
      required this.unsatisfied,
      required this.veryPleased});
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
        dissatisfaction: json['Rất không hài lòng'] ?? 0,
        normal: json['Bình thường'] ?? 0,
        pleased: json['Hài lòng'] ?? 0,
        unsatisfied: json['Không hài lòng'] ?? 0,
        veryPleased: json['Rất hài lòng'] ?? 0);
  }
}
