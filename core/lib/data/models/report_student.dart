class ReportStudent {
  final CommentTeacher comment;
  final TeacherName teacherName;
  final List<ListMarks> listMarks;
  final List<DataItem> dataItems;
  const ReportStudent(
      {required this.dataItems,
      required this.listMarks,
      required this.comment,
      required this.teacherName});
  factory ReportStudent.fromJson(Map<String, dynamic> json) {
    return ReportStudent(
        comment: CommentTeacher.fromJson(json['comment']),
        teacherName: TeacherName.fromJson(json['teacher_name']),
        dataItems: List<DataItem>.from(
            json['data']['items']?.map(DataItem.fromJson) ?? []),
        listMarks: List<ListMarks>.from(
            json['list_marks']['items']?.map(ListMarks.fromJson) ??
                []));
  }
}

class CommentTeacher {
  final String label;
  final String value;
  const CommentTeacher({required this.label, required this.value});
  factory CommentTeacher.fromJson(Map<String, dynamic> json) {
    return CommentTeacher(
        label: json['label'] ?? '', value: json['value'] ?? '');
  }
}

class TeacherName {
  final String label;
  final String value;
  const TeacherName({required this.label, required this.value});
  factory TeacherName.fromJson(Map<String, dynamic> json) {
    return TeacherName(label: json['label'] ?? '', value: json['value'] ?? '');
  }
}

class ListMarks {
  final int id;
  final String title;
  final String description;
  final int value;
  final int evaluationFromId;
  final int userId;
  final int schoolId;
  ListMarks(
      {required this.description,
      required this.evaluationFromId,
      required this.id,
      required this.title,
      required this.schoolId,
      required this.userId,
      required this.value});
  factory ListMarks.fromJson(Map<String, dynamic> json) {
    return ListMarks(
        description: json['description'] ?? '',
        evaluationFromId: json['evaluation_form_id'] ?? 0,
        id: json['id'] ?? 0,
        schoolId: json['school_id'] ?? 0,
        title: json['title'] ?? '',
        userId: json['user_id'] ?? 0,
        value: json['value'] ?? 0);
  }
}

class DataItem {
  final int id;
  final String title;
  final int evaluationFormId;
  final int priority;
  final List<ChildrenItems> childrenItems;
  const DataItem(
      {required this.childrenItems,
      required this.evaluationFormId,
      required this.id,
      required this.priority,
      required this.title});
  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
        childrenItems: List<ChildrenItems>.from(
            json['children_items']?.map(ChildrenItems.fromJson) ??
                []),
        evaluationFormId: json['evaluation_form_id'] ?? 0,
        id: json['id'] ?? 0,
        priority: json['priority'] ?? 0,
        title: json['title'] ?? '');
  }
}

class ChildrenItems {
  final int id;
  final String title;
  final int evaluationFormId;
  final int priority;
  final List<DataChildrenItems> dataChildrenItems;
  const ChildrenItems(
      {required this.dataChildrenItems,
      required this.evaluationFormId,
      required this.id,
      required this.priority,
      required this.title});
  factory ChildrenItems.fromJson(Map<String, dynamic> json) {
    return ChildrenItems(
        dataChildrenItems: List<DataChildrenItems>.from(
            json['children_items']?.map(DataChildrenItems.fromJson) ??
                []),
        evaluationFormId: json['evaluation_form_id'] ?? 0,
        id: json['id'] ?? 0,
        priority: json['priority'] ?? 0,
        title: json['title'] ?? '');
  }
}

class DataChildrenItems {
  final int id;
  final String title;
  final int evaluationFormId;
  final List<ListCriterial> listCriterial;
  const DataChildrenItems(
      {required this.evaluationFormId,
      required this.id,
      required this.listCriterial,
      required this.title});
  factory DataChildrenItems.fromJson(Map<String, dynamic> json) {
    return DataChildrenItems(
        evaluationFormId: json['evaluation_form_id'] ?? 0,
        id: json['id'] ?? 0,
        listCriterial: List<ListCriterial>.from(
            json['list_criterial']?.map(ListCriterial.fromJson) ??
                []),
        title: json['title'] ?? '');
  }
}

class ListCriterial {
  final int id;
  final int evaluationFormId;
  final int criterialId;
  final String criterialTitle;
  final List<Result> result;
  const ListCriterial(
      {required this.criterialId,
      required this.criterialTitle,
      required this.evaluationFormId,
      required this.id,
      required this.result});
  factory ListCriterial.fromJson(Map<String, dynamic> json) {
    return ListCriterial(
        criterialId: json['criterial_id'] ?? 0,
        criterialTitle: json['criterial_title'] ?? '',
        evaluationFormId: json['evaluation_form_id'] ?? 0,
        id: json['id'] ?? 0,
        result: List<Result>.from(
            json['result']?.map(Result.fromJson) ?? []));
  }
}

class Result {
  final int markId;
  const Result({required this.markId});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(markId: json['mark_id'] ?? 0);
  }
}
