class Semester {
  final int value;
  final String title;
  const Semester({
    required this.title,
    required this.value,
  });
  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      title: json['title'] ?? '',
      value: json['value'] ?? 0,
    );
  }
}
