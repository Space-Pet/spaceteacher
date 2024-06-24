class FormDetail {
  final FormInfo formInfo;
  final FormDataTeacher data;
  final CommentTeacher comment;
  final TeacherNameReport teacherName;
  final List<Mark> listMarks;

  FormDetail({
    required this.formInfo,
    required this.data,
    required this.comment,
    required this.teacherName,
    required this.listMarks,
  });

  factory FormDetail.fromJson(Map<String, dynamic> json) {
    return FormDetail(
      formInfo: FormInfo.fromJson(json['form_info']),
      data: FormDataTeacher.fromJson(json['data']),
      comment: CommentTeacher.fromJson(json['comment']),
      teacherName: TeacherNameReport.fromJson(json['teacher_name']),
      listMarks: (json['list_marks']['items'] as List)
          .map((item) => Mark.fromJson(item))
          .toList(),
    );
  }

  factory FormDetail.empty() => FormDetail(
        formInfo: FormInfo.empty(),
        data: FormDataTeacher.empty(),
        comment: CommentTeacher.empty(),
        teacherName: TeacherNameReport.empty(),
        listMarks: [],
      );

  static List<FormDetail> fakeData() {
    return List.generate(
      4,
      (index) => FormDetail(
        formInfo: FormInfo.fakeData(index),
        data: FormDataTeacher.fakeData(),
        comment: CommentTeacher.fakeData(index),
        teacherName: TeacherNameReport.fakeData(index),
        listMarks: List.generate(
          4,
          (i) => Mark.fakeData(i),
        ),
      ),
    );
  }
}

class FormInfo {
  final int id;
  final String title;
  final String description;
  final String lang;
  final int semester;
  final String learnYear;

  FormInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.lang,
    required this.semester,
    required this.learnYear,
  });

  factory FormInfo.fromJson(Map<String, dynamic> json) {
    return FormInfo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      lang: json['lang'],
      semester: json['semester'],
      learnYear: json['learn_year'],
    );
  }

  factory FormInfo.empty() => FormInfo(
        id: 0,
        title: '',
        description: '',
        lang: '',
        semester: 0,
        learnYear: '',
      );

  static FormInfo fakeData(int index) => FormInfo(
        id: index,
        title: 'title $index',
        description: 'description $index',
        lang: 'lang $index',
        semester: index,
        learnYear: 'learnYear $index',
      );
}

class FormDataTeacher {
  final String headingText;
  final List<Item> items;

  FormDataTeacher({
    required this.headingText,
    required this.items,
  });

  factory FormDataTeacher.fromJson(Map<String, dynamic> json) {
    return FormDataTeacher(
      headingText: json['heading_text'],
      items:
          (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
    );
  }

  factory FormDataTeacher.empty() => FormDataTeacher(
        headingText: '',
        items: [],
      );

  static FormDataTeacher fakeData() => FormDataTeacher(
        headingText: 'Sample heading text',
        items: List.generate(4, (index) => Item.fakeData(index)),
      );
}

class Item {
  final int id;
  final String title;
  final List<Criterial> listCriterial;

  Item({
    required this.id,
    required this.title,
    required this.listCriterial,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    var listCriterialJson =
        json['list_criterial'] ?? json['children_items'] ?? [];
    return Item(
      id: json['id'],
      title: json['title'],
      listCriterial: (listCriterialJson as List)
          .map((criterial) => Criterial.fromJson(criterial))
          .toList(),
    );
  }

  factory Item.empty() => Item(
        id: 0,
        title: '',
        listCriterial: [],
      );

  static Item fakeData(int index) => Item(
        id: index,
        title: 'title $index',
        listCriterial: List.generate(4, (i) => Criterial.fakeData(i)),
      );
}

class Criterial {
  final int id;
  final String criterialTitle;
  final int evaluationFormId;
  final int criterialMappingId;
  final int criterialCategoryId;
  final List<ResultTeacher> result;
  final List<Mark> listMarks;

  Criterial({
    required this.criterialCategoryId,
    required this.criterialMappingId,
    required this.evaluationFormId,
    required this.id,
    required this.criterialTitle,
    required this.result,
    required this.listMarks,
  });

  factory Criterial.fromJson(Map<String, dynamic> json) {
    return Criterial(
      criterialCategoryId: json['criterial_category_id'] ?? 0,
      criterialMappingId: json['criterial_mapping_id'] ?? 0,
      evaluationFormId: json['evaluation_form_id'] ?? 0,
      id: json['id'],
      criterialTitle: json['criterial_title'],
      result: (json['result'] as List)
          .map((res) => ResultTeacher.fromJson(res))
          .toList(),
      listMarks: (json['list_marks'] as List)
          .map((mark) => Mark.fromJson(mark))
          .toList(),
    );
  }

  factory Criterial.empty() => Criterial(
        evaluationFormId: 0,
        criterialCategoryId: 0,
        criterialMappingId: 0,
        id: 0,
        criterialTitle: '',
        result: [],
        listMarks: [],
      );

  static Criterial fakeData(int index) => Criterial(
        evaluationFormId: index,
        criterialCategoryId: index,
        criterialMappingId: index,
        id: index,
        criterialTitle: 'criterialTitle $index',
        result: List.generate(4, (i) => ResultTeacher.fakeData(i)),
        listMarks: List.generate(4, (i) => Mark.fakeData(i)),
      );
}

class ResultTeacher {
  final int id;
  final int pupilId;
  final int markId;
  final String textResult;

  ResultTeacher({
    required this.id,
    required this.pupilId,
    required this.markId,
    required this.textResult,
  });

  factory ResultTeacher.fromJson(Map<String, dynamic> json) {
    return ResultTeacher(
      id: json['id'],
      pupilId: json['pupil_id'],
      markId: json['mark_id'],
      textResult: json['text_result'] ?? '',
    );
  }

  factory ResultTeacher.empty() => ResultTeacher(
        id: 0,
        pupilId: 0,
        markId: 0,
        textResult: '',
      );

  static ResultTeacher fakeData(int index) => ResultTeacher(
        id: index,
        pupilId: index,
        markId: index,
        textResult: 'textResult $index',
      );
}

class Mark {
  final int id;
  final String title;
  final String description;
  final int value;

  Mark({
    required this.id,
    required this.title,
    required this.description,
    required this.value,
  });

  factory Mark.fromJson(Map<String, dynamic> json) {
    return Mark(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      value: json['value'],
    );
  }

  factory Mark.empty() => Mark(
        id: 0,
        title: '',
        description: '',
        value: 0,
      );

  static Mark fakeData(int index) => Mark(
        id: index,
        title: 'title $index',
        description: 'description $index',
        value: index,
      );
}

class CommentTeacher {
  final String label;
  final String value;

  CommentTeacher({
    required this.label,
    required this.value,
  });

  factory CommentTeacher.fromJson(Map<String, dynamic> json) {
    return CommentTeacher(
      label: json['label'],
      value: json['value'],
    );
  }

  factory CommentTeacher.empty() => CommentTeacher(
        label: '',
        value: '',
      );

  static CommentTeacher fakeData(int index) => CommentTeacher(
        label: 'label $index',
        value: 'value $index',
      );
}

class TeacherNameReport {
  final String label;
  final String value;

  TeacherNameReport({
    required this.label,
    required this.value,
  });

  factory TeacherNameReport.fromJson(Map<String, dynamic> json) {
    return TeacherNameReport(
      label: json['label'],
      value: json['value'],
    );
  }

  factory TeacherNameReport.empty() => TeacherNameReport(
        label: '',
        value: '',
      );

  static TeacherNameReport fakeData(int index) => TeacherNameReport(
        label: 'label $index',
        value: 'value $index',
      );
}
