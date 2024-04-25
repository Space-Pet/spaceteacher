import 'package:json_annotation/json_annotation.dart';
part 'absence_form_detail_model.g.dart';

@JsonSerializable()
class AbsenceFormDetailModel {
  final int? id;
  final String? title;
  final String? content;
  @JsonKey(name: 'leave_type')
  final int? leaveType;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'status')
  final StatusAbsenceModel? status;

  AbsenceFormDetailModel(
      {this.id,
      this.title,
      this.content,
      this.leaveType,
      this.startDate,
      this.endDate,
      this.status});

  factory AbsenceFormDetailModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenceFormDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$AbsenceFormDetailModelToJson(this);

  @override
  String toString() {
    return 'AbsenceFormDetailModel{id: $id, title: $title, content: $content, leaveType: $leaveType, startDate: $startDate, endDate: $endDate, status: $status}';
  }

  AbsenceFormDetailModel copyWith({
    int? id,
    String? title,
    String? content,
    int? leaveType,
    String? startDate,
    String? endDate,
    StatusAbsenceModel? status,
  }) {
    return AbsenceFormDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}

@JsonSerializable()
class StatusAbsenceModel {
  final String? value;
  final String? text;
  StatusAbsenceModel({this.value, this.text});

  factory StatusAbsenceModel.fromJson(Map<String, dynamic> json) =>
      _$StatusAbsenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusAbsenceModelToJson(this);

  @override
  String toString() {
    return 'StatusAbsenceModel{value: $value, text: $text}';
  }
}
