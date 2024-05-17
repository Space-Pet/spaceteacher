import 'package:json_annotation/json_annotation.dart';
part 'update_hourly_assessment.g.dart';

@JsonSerializable()
class UpdateHourlyAssessment {
  @JsonKey(name: 'lesson_register_id')
  final int? lessonRegisterId;
  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'NOTE_ID')
  final String? noteId;
  @JsonKey(name: 'diem_dat')
  final double? scoreAchieved;
  @JsonKey(name: 'tieu_chi_diem')
  final double? scoreCriteria;
  @JsonKey(name: 'nhan_xet')
  final String? comments;
  final String? status;
  @JsonKey(name: 'status_note')
  final String? statusNote;

  UpdateHourlyAssessment({
    this.lessonRegisterId,
    this.userKey,
    this.noteId,
    this.scoreAchieved,
    this.scoreCriteria,
    this.comments,
    this.status,
    this.statusNote,
  });

  factory UpdateHourlyAssessment.fromJson(Map<String, dynamic> json) =>
      _$UpdateHourlyAssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateHourlyAssessmentToJson(this);

  @override
  String toString() {
    return 'UpdateHourlyAssessment{lessonRegisterId: $lessonRegisterId, userKey: $userKey, noteId: $noteId, scoreAchieved: $scoreAchieved, scoreCriteria: $scoreCriteria, comments: $comments, status: $status, statusNote: $statusNote}';
  }

  UpdateHourlyAssessment copyWith({
    int? lessonRegisterId,
    String? userKey,
    String? noteId,
    double? scoreAchieved,
    double? scoreCriteria,
    String? comments,
    String? status,
    String? statusNote,
  }) {
    return UpdateHourlyAssessment(
      lessonRegisterId: lessonRegisterId ?? this.lessonRegisterId,
      userKey: userKey ?? this.userKey,
      noteId: noteId ?? this.noteId,
      scoreAchieved: scoreAchieved ?? this.scoreAchieved,
      scoreCriteria: scoreCriteria ?? this.scoreCriteria,
      comments: comments ?? this.comments,
      status: status ?? this.status,
      statusNote: statusNote ?? this.statusNote,
    );
  }
}
