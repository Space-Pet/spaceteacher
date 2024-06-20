class ListAllForm {
  final int id;
  final String title;
  final String description;
  final String language;
  final String classTitle;
  final String schoolBrand;
  final String learnYear;
  final int status;
  final int semester;

  ListAllForm({
    required this.classTitle,
    required this.description,
    required this.id,
    required this.language,
    required this.learnYear,
    required this.schoolBrand,
    required this.semester,
    required this.status,
    required this.title,
  });

  factory ListAllForm.fromJson(Map<String, dynamic> json) {
    return ListAllForm(
      classTitle: json['class_title'] ?? '',
      description: json['description'] ?? '',
      id: json['id'] ?? 0,
      language: json['language'] ?? '',
      learnYear: json['learn_year'] ?? '',
      schoolBrand: json['school_brand'] ?? '',
      semester: json['semester'] ?? 0,
      status: json['status'] ?? 0,
      title: json['title'] ?? '',
    );
  }

  factory ListAllForm.empty() => ListAllForm(
        classTitle: '',
        description: '',
        id: 0,
        language: '',
        learnYear: '',
        schoolBrand: '',
        semester: 0,
        status: 0,
        title: '',
      );

  static List<ListAllForm> fakeDate() {
    return List.generate(
      4,
      (index) => ListAllForm(
        classTitle: 'classTitle $index',
        description: 'description $index',
        id: index,
        language: 'language $index',
        learnYear: 'learnYear $index',
        schoolBrand: 'schoolBrand $index',
        semester: index,
        status: index,
        title: 'title $index',
      ),
    );
  }
}
