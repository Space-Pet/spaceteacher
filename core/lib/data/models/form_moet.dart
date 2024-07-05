import '../../core.dart';

class FormMoet {
  final String capDaoTao;
  final List<ItemsFormMoet> itemsFormMoet;
  FormMoet({required this.capDaoTao, required this.itemsFormMoet});
  factory FormMoet.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<ItemsFormMoet> dataList =
        list.map((i) => ItemsFormMoet.fromJson(i)).toList();
    return FormMoet(
      capDaoTao: json['cap_dao_tao'],
      itemsFormMoet: dataList,
    );
  }

  factory FormMoet.empty() => FormMoet(
        capDaoTao: '',
        itemsFormMoet: [],
      );
}

class ItemsFormMoet {
  final int pupilId;
  final String pupilName;
  final int classId;
  final int subjectId;
  final PupilImage pupilImage;
  final StudyGoal studyGoals;
  ItemsFormMoet({
    required this.classId,
    required this.pupilName,
    required this.pupilId,
    required this.pupilImage,
    required this.studyGoals,
    required this.subjectId,
  });

  factory ItemsFormMoet.fromJson(Map<String, dynamic> json) {
    return ItemsFormMoet(
      classId: json['class_id'],
      pupilName: json['pupil_name'],
      pupilId: json['pupil_id'],
      pupilImage: PupilImage.fromJson(json['pupil_image']),
      studyGoals: StudyGoal.fromJson(json['study_goals']),
      subjectId: json['subject_id'],
    );
  }
}

class PupilImage {
  final String web;
  final String mobile;
  PupilImage({
    required this.mobile,
    required this.web,
  });
  factory PupilImage.fromJson(Map<String, dynamic> json) {
    return PupilImage(
      mobile: json['mobile'],
      web: json['web'],
    );
  }
  factory PupilImage.empty() => PupilImage(
        mobile: '',
        web: '',
      );
}

class StudyGoal {
  final String type;
  final String? option;
  StudyGoal({
    required this.option,
    required this.type,
  });
  factory StudyGoal.fromJson(Map<String, dynamic> json) {
    return StudyGoal(
      option: json['option'],
      type: json['type'],
    );
  }
  factory StudyGoal.empty() => StudyGoal(
        option: '',
        type: '',
      );
}
