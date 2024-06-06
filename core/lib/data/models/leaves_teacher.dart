import 'dart:convert';

class LeaveTeacher {
  int id;
  int pupilId;
  String pupilName;
  String title;
  String content;
  int leaveType;
  DateTime startDate;
  DateTime endDate;
  LeaveStatus status;

  LeaveTeacher({
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

  factory LeaveTeacher.fromMap(Map<String, dynamic> map) {
    return LeaveTeacher(
      id: map['id'],
      pupilId: map['pupil_id'],
      pupilName: map['pupil_name'],
      title: map['title'],
      content: map['content'],
      leaveType: map['leave_type'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      status: LeaveStatus.fromMap(map['status']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pupil_id': pupilId,
      'pupil_name': pupilName,
      'title': title,
      'content': content,
      'leave_type': leaveType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status.toMap(),
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory LeaveTeacher.empty() {
    return LeaveTeacher(
      id: 0,
      pupilId: 0,
      pupilName: '',
      title: '',
      content: '',
      leaveType: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      status: LeaveStatus(
        value: LeaveStatusValue.pending,
        text: '',
      ),
    );
  }
}

enum LeaveStatusValue {
  pending,
  approved,
}

extension LeaveStatusValueExtension on LeaveStatusValue {
  String get value {
    switch (this) {
      case LeaveStatusValue.pending:
        return 'pending';
      case LeaveStatusValue.approved:
        return 'approved';
    }
  }

  String get text {
    switch (this) {
      case LeaveStatusValue.pending:
        return 'Chưa duyệt';
      case LeaveStatusValue.approved:
        return 'Đã duyệt';
    }
  }
}

class LeaveStatus {
  LeaveStatusValue value;
  String text;

  LeaveStatus({
    required this.value,
    required this.text,
  });

  factory LeaveStatus.fromMap(Map<String, dynamic> map) {
    final value =
        LeaveStatusValue.values.firstWhere((e) => e.value == map['value']);

    return LeaveStatus(
      text: map['text'],
      value: value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'text': text,
    };
  }
}
