class ListStudentFormReport {
  final int id;
  final String fullName;
  final String? description;
  final int approve;
  final int evaluated;
  final String evaluationFormId;

  ListStudentFormReport({
    required this.id,
    required this.fullName,
    this.description,
    required this.approve,
    required this.evaluated,
    required this.evaluationFormId,
  });

  factory ListStudentFormReport.fromJson(Map<String, dynamic> json) {
    return ListStudentFormReport(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      description: json['description'] ?? '',
      approve: json['approve'] ?? 0,
      evaluated: json['evaluated'] ?? 0,
      evaluationFormId: json['evaluation_form_id'] ?? '',
    );
  }

  factory ListStudentFormReport.empty() => ListStudentFormReport(
        id: 0,
        fullName: '',
        description: '',
        approve: 0,
        evaluated: 0,
        evaluationFormId: '',
      );

  static List<ListStudentFormReport> fakeData() {
    return List.generate(
      4,
      (index) => ListStudentFormReport(
          id: index,
          fullName: '',
          description: '',
          approve: index,
          evaluated: index,
          evaluationFormId: ''),
    );
  }
}
