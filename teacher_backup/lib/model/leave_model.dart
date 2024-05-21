import 'package:json_annotation/json_annotation.dart';

part 'leave_model.g.dart';

@JsonSerializable()
class LeaveModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'pupil_id')
  final int pupilId;
  @JsonKey(name: 'pupil_name')
  final String pupilName;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'leave_type')
  final int leaveType;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @JsonKey(name: 'status')
  final Status status;

  const LeaveModel({
    required this.id,
    required this.pupilId,
    required this.pupilName,
    required this.title,
    required this.content,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveModelToJson(this);

  LeaveModel copyWith({
    int? id,
    int? pupilId,
    String? pupilName,
    String? title,
    String? content,
    int? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    Status? status,
  }) {
    return LeaveModel(
      id: id ?? this.id,
      pupilId: pupilId ?? this.pupilId,
      pupilName: pupilName ?? this.pupilName,
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
class Status {
  @JsonKey(name: 'value')
  final String value;
  @JsonKey(name: 'text')
  final String text;

  const Status({
    required this.value,
    required this.text,
  });

  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  Status copyWith({
    String? value,
    String? text,
  }) {
    return Status(
      value: value ?? this.value,
      text: text ?? this.text,
    );
  }
}
