import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/weekly_lesson_data_model.dart';
part 'register_notebook_model.g.dart';

@JsonSerializable()
class RegisterNotebookModel {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @JsonKey(name: 'teacher_fullname')
  final String? teacherFullname;
  @JsonKey(name: 'txt_date')
  final String? txtDate;
  @JsonKey(name: 'txt_week')
  final String? txtWeek;
  @JsonKey(name: 'txt_begin_day')
  final String? txtBeginDay;
  @JsonKey(name: 'txt_end_day')
  final String? txtEndDay;
  @JsonKey(name: 'txt_pre_week')
  final String? txtPreWeek;
  @JsonKey(name: 'txt_next_week')
  final String? txtNextWeek;
  final String? status;
  @JsonKey(name: 'status_note')
  final String? statusNote;
  @JsonKey(name: 'weeklylesson_data')
  final List<WeeklyLessonDataModel>? weeklyLessonData;

  RegisterNotebookModel({
    this.userId,
    this.teacherId,
    this.teacherFullname,
    this.txtDate,
    this.txtWeek,
    this.txtBeginDay,
    this.txtEndDay,
    this.txtPreWeek,
    this.txtNextWeek,
    this.status,
    this.statusNote,
    this.weeklyLessonData,
  });

  factory RegisterNotebookModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterNotebookModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterNotebookModelToJson(this);

  @override
  String toString() {
    return 'RegisterNotebookModel{userId: $userId, teacherId: $teacherId, teacherFullname: $teacherFullname, txtDate: $txtDate, txtWeek: $txtWeek, txtBeginDay: $txtBeginDay, txtEndDay: $txtEndDay, txtPreWeek: $txtPreWeek, txtNextWeek: $txtNextWeek, status: $status, statusNote: $statusNote, weeklyLessonData: $weeklyLessonData}';
  }

  RegisterNotebookModel copyWith({
    String? userId,
    String? teacherId,
    String? teacherFullname,
    String? txtDate,
    String? txtWeek,
    String? txtBeginDay,
    String? txtEndDay,
    String? txtPreWeek,
    String? txtNextWeek,
    String? status,
    String? statusNote,
    List<WeeklyLessonDataModel>? weeklyLessonData,
  }) {
    return RegisterNotebookModel(
      userId: userId ?? this.userId,
      teacherId: teacherId ?? this.teacherId,
      teacherFullname: teacherFullname ?? this.teacherFullname,
      txtDate: txtDate ?? this.txtDate,
      txtWeek: txtWeek ?? this.txtWeek,
      txtBeginDay: txtBeginDay ?? this.txtBeginDay,
      txtEndDay: txtEndDay ?? this.txtEndDay,
      txtPreWeek: txtPreWeek ?? this.txtPreWeek,
      txtNextWeek: txtNextWeek ?? this.txtNextWeek,
      status: status ?? this.status,
      statusNote: statusNote ?? this.statusNote,
      weeklyLessonData: weeklyLessonData ?? this.weeklyLessonData,
    );
  }
}
