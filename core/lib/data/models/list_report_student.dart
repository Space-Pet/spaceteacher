class ListReportStudent {
  final int id;
  final String title;
  final String description;
  final int status;
  final int semester;
  const ListReportStudent(
      {required this.description,
      required this.id,
      required this.semester,
      required this.status,
      required this.title});
  factory ListReportStudent.fromJson(Map<String, dynamic> json) {
    return ListReportStudent(
        description: json['description'] ?? '',
        id: json['id'] ?? 0,
        semester: json['semester'] ?? 0,
        status: json['status'] ?? 0,
        title: json['title'] ?? '');
  }
}
