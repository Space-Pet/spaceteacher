import 'dart:convert';

import 'package:intl/intl.dart';

class ExerciseData {
  final List<ExerciseItem> exerciseDataList;

  ExerciseData({required this.exerciseDataList});

  factory ExerciseData.fromMap(Map<String, dynamic> map) {
    if (map['data'] == null) {
      return ExerciseData(exerciseDataList: []);
    }
    return ExerciseData(
      exerciseDataList: List<ExerciseItem>.from(
        map['data']?.map(
          (x) => ExerciseItem.fromMap(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': List<dynamic>.from(
        exerciseDataList.map(
          (x) => x.toMap(),
        ),
      ),
    };
  }

  factory ExerciseData.fromJson(String source) =>
      ExerciseData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
  DateFormat formatDateDrill = DateFormat("dd-MM-yyyy", 'vi_VN');

  String getInitTime() {
    return formatDateDrill.format(DateTime.now());
  }

  List<String> getSubjectList() {
    Set<String> uniqueSubjects =
        exerciseDataList.map((e) => e.subjectName).toSet();
    List<String> subjectList = uniqueSubjects.toList();
    subjectList.insert(0, "Tất cả các môn");
    return subjectList;
  }

  factory ExerciseData.empty() => ExerciseData(exerciseDataList: []);

  @override
  String toString() => 'ExerciseData(exerciseDataList: $exerciseDataList)';
}

class ExerciseItem {
  final String lessonId;
  final String? lessonName;
  final String subjectId;
  final String subjectName;
  final String lessonNote;
  final String? danDoBaoBai;
  final String? fileBaoBai;
  final String? fileBaoBaiDomain;
  final String? linkBaoBai;
  final String? hanNopBaoBai;
  final String teacherId;
  final String teacherName;
  final String tietNum;
  final String className;
  final String classId;
  final String lessonStatus;

  ExerciseItem({
    required this.lessonId,
    this.lessonName,
    required this.subjectId,
    required this.subjectName,
    required this.lessonNote,
    this.danDoBaoBai,
    this.fileBaoBai,
    this.fileBaoBaiDomain,
    this.linkBaoBai,
    this.hanNopBaoBai,
    required this.teacherId,
    required this.teacherName,
    required this.tietNum,
    required this.className,
    required this.classId,
    required this.lessonStatus,
  });

  factory ExerciseItem.fromMap(Map<String, dynamic> map) {
    return ExerciseItem(
      lessonId: map['lesson_id'],
      lessonName: map['lesson_name'],
      subjectId: map['subject_id'],
      subjectName: map['subject_name'],
      lessonNote: map['lesson_note'],
      danDoBaoBai: map['dan_do_bao_bai'],
      fileBaoBai: map['file_bao_bai'],
      fileBaoBaiDomain: map['file_bao_bai_domain'],
      linkBaoBai: map['link_bao_bai'],
      hanNopBaoBai: map['bao_bai_han_nop'],
      teacherId: map['teacher_id'],
      teacherName: map['teacher_name'],
      tietNum: map['tiet_num'],
      className: map['class_name'],
      classId: map['class_id'],
      lessonStatus: map['lesson_status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lesson_id': lessonId,
      'lesson_name': lessonName,
      'subject_id': subjectId,
      'subject_name': subjectName,
      'lesson_note': lessonNote,
      'dan_do_bao_bai': danDoBaoBai,
      'file_bao_bai': fileBaoBai,
      'file_bao_bai_domain': fileBaoBaiDomain,
      'link_bao_bai': linkBaoBai,
      'bao_bai_han_nop': hanNopBaoBai,
      'teacher_id': teacherId,
      'teacher_name': teacherName,
      'tiet_num': tietNum,
      'class_name': className,
      'class_id': classId,
      'lesson_status': lessonStatus,
    };
  }

  factory ExerciseItem.fromJson(String source) =>
      ExerciseItem.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ExerciseItem(lessonId: $lessonId, lessonName: $lessonName, subjectId: $subjectId, subjectName: $subjectName, lessonNote: $lessonNote, danDoBaoBai: $danDoBaoBai, fileBaoBai: $fileBaoBai, fileBaoBaiDomain: $fileBaoBaiDomain, linkBaoBai: $linkBaoBai, hanNopBaoBai: $hanNopBaoBai, teacherId: $teacherId, teacherName: $teacherName, tietNum: $tietNum, className: $className, classId: $classId,classId: $lessonStatus)';

  static empty() {
    return ExerciseItem(
      lessonId: '',
      lessonName: '',
      subjectId: '',
      subjectName: '',
      lessonNote: '',
      danDoBaoBai: '',
      fileBaoBai: '',
      fileBaoBaiDomain: '',
      linkBaoBai: '',
      hanNopBaoBai: '',
      teacherId: '',
      teacherName: '',
      tietNum: '',
      className: '',
      classId: '',
      lessonStatus: '',
    );
  }
}
