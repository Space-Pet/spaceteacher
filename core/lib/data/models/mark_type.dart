class MarkTypeColumn {
  final String label;
  final String type;
  final dynamic value;
  MarkTypeColumn({
    required this.label,
    required this.type,
    required this.value,
  });
  factory MarkTypeColumn.fromJson(Map<String, dynamic> json) {
    return MarkTypeColumn(
      label: json['label'],
      type: json['type'],
      value: json['value'],
    );
  }

  static List<MarkTypeColumn> fakeData() {
    return List.generate(
      3,
      (index) => MarkTypeColumn(label: '', type: '', value: 0),
    );
  }

  static List<MarkTypeColumn> fakeDataESL() {
    return [
      MarkTypeColumn(label: 'Xem điểm', type: 'esl', value: 'score'),
      MarkTypeColumn(label: 'Xem GPA', type: 'esl', value: 'gpa'),
    ];
  }
}
