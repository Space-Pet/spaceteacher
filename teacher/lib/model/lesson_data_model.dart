import 'package:json_annotation/json_annotation.dart';
part 'lesson_data_model.g.dart';

@JsonSerializable()
class LessonDataModel {
  @JsonKey(name: 'lesson_id')
  final String? id;
  @JsonKey(name: 'lesson_name')
  final String? name;
  @JsonKey(name: 'subject_id')
  final String? subjectId;
  @JsonKey(name: 'subject_name')
  final String? subjectName;
  @JsonKey(name: 'lesson_note')
  final String? note;
  @JsonKey(name: 'dan_do_bao_bai')
  final String? danDoBaoBai;
  @JsonKey(name: 'file_bao_bai')
  final String? fileBaoBai;
  @JsonKey(name: 'file_bao_bai_domain')
  final String? fileBaoBaiDomain;
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @JsonKey(name: 'class_id')
  final String? classId;
  @JsonKey(name: 'class_name')
  final String? className;
  @JsonKey(name: 'tiet_num')
  final String? tietNum;
  @JsonKey(name: 'lesson_status')
  final String? lessonStatus;
  @JsonKey(name: 'lesson_rank')
  final List<LessonRankModel>? lessonRank;
  @JsonKey(name: 'link_bao_bai')
  final String? linkBaoBai;
  @JsonKey(name: 'han_nop_bai')
  final String? hanNopBai;
  @JsonKey(name: 'tiet_status_note')
  final String? tietStatusNote;

  LessonDataModel({
    this.id,
    this.name,
    this.subjectId,
    this.subjectName,
    this.note,
    this.danDoBaoBai,
    this.fileBaoBai,
    this.fileBaoBaiDomain,
    this.teacherId,
    this.classId,
    this.className,
    this.tietNum,
    this.lessonStatus,
    this.lessonRank,
    this.linkBaoBai,
    this.hanNopBai,
    this.tietStatusNote,
  });

  factory LessonDataModel.fromJson(Map<String, dynamic> json) =>
      _$LessonDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonDataModelToJson(this);

  @override
  String toString() {
    return 'LessonDataModel{id: $id, name: $name, subjectId: $subjectId, subjectName: $subjectName, note: $note, danDoBaoBai: $danDoBaoBai, fileBaoBai: $fileBaoBai, fileBaoBaiDomain: $fileBaoBaiDomain, teacherId: $teacherId, classId: $classId, className: $className, tietNum: $tietNum, lessonStatus: $lessonStatus, lessonRank: $lessonRank, linkBaoBai: $linkBaoBai, hanNopBai: $hanNopBai, tietStatusNote: $tietStatusNote}';
  }

  LessonDataModel copyWith({
    String? id,
    String? name,
    String? subjectId,
    String? subjectName,
    String? note,
    String? danDoBaoBai,
    String? fileBaoBai,
    String? fileBaoBaiDomain,
    String? teacherId,
    String? classId,
    String? className,
    String? tietNum,
    String? lessonStatus,
    List<LessonRankModel>? lessonRank,
    String? linkBaoBai,
    String? hanNopBai,
    String? tietStatusNote,
  }) {
    return LessonDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      note: note ?? this.note,
      danDoBaoBai: danDoBaoBai ?? this.danDoBaoBai,
      fileBaoBai: fileBaoBai ?? this.fileBaoBai,
      fileBaoBaiDomain: fileBaoBaiDomain ?? this.fileBaoBaiDomain,
      teacherId: teacherId ?? this.teacherId,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      tietNum: tietNum ?? this.tietNum,
      lessonStatus: lessonStatus ?? this.lessonStatus,
      lessonRank: lessonRank ?? this.lessonRank,
      linkBaoBai: linkBaoBai ?? this.linkBaoBai,
      hanNopBai: hanNopBai ?? this.hanNopBai,
      tietStatusNote: tietStatusNote ?? this.tietStatusNote,
    );
  }
}

@JsonSerializable()
class LessonRankModel {
  @JsonKey(name: 'lesson_rank_key')
  final int? lessonRankKey;
  @JsonKey(name: 'lesson_rank_name')
  final String? lessonRankName;
  final int? active;

  LessonRankModel({
    this.lessonRankKey,
    this.lessonRankName,
    this.active,
  });

  factory LessonRankModel.fromJson(Map<String, dynamic> json) =>
      _$LessonRankModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonRankModelToJson(this);

  @override
  String toString() {
    return 'LessonRankModel{lessonRankKey: $lessonRankKey, lessonRankName: $lessonRankName, active: $active}';
  }

  LessonRankModel copyWith({
    int? lessonRankKey,
    String? lessonRankName,
    int? active,
  }) {
    return LessonRankModel(
      lessonRankKey: lessonRankKey ?? this.lessonRankKey,
      lessonRankName: lessonRankName ?? this.lessonRankName,
      active: active ?? this.active,
    );
  }
}
