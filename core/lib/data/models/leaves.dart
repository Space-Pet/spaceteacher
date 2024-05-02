class LeaveData {
  final int id;
  final String title;
  final String content;
  final int leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String value;
  final String text;
  const LeaveData({
    required this.id,
    required this.title,
    required this.content,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.text,
    required this.value,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    return LeaveData(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        leaveType: json['leave_type'] ?? '',
        startDate: DateTime.tryParse(json['start_date']) ?? DateTime.now(),
        endDate: DateTime.tryParse(json['end_date']) ?? DateTime.now(),
        value: json['status']['value'] ?? '',
        text: json['status']['text'] ?? '');
  }
}
