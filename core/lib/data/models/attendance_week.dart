class AttendanceWeek {
  final int totalLessons;
  final int countPresent;
  final AbsentData absentData;
  const AttendanceWeek(
      {required this.absentData,
      required this.countPresent,
      required this.totalLessons});
  factory AttendanceWeek.fromJson(Map<String, dynamic> json) {
    final absentData = AbsentData.fromJson(json['absent_data']);
    return AttendanceWeek(
        absentData: absentData,
        countPresent: json['count_present'] ?? 0,
        totalLessons: json['total_lessons'] ?? 0);
  }
}

class AbsentData {
  final int count;
  final List<Items>? items;
  const AbsentData({required this.count, required this.items});
  factory AbsentData.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>?)
        ?.map((e) => Items.fromJson(e))
        .toList();
    return AbsentData(count: json['count'] ?? 0, items: items);
  }
}

class Items {
  final String date;
  final List<DataItems>? data;
  const Items({required this.date, required this.data});
  factory Items.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as List<dynamic>?)
        ?.map((e) => DataItems.fromJson(e))
        .toList();
    return Items(date: json['date'] ?? '', data: data);
  }
}

class DataItems {
  final int id;
  final int subjectId;
  final String subjectName;
  final String numberOfClassPeriod;
  final String description;
  final String date;
  const DataItems(
      {required this.description,
      required this.id,
      required this.date,
      required this.numberOfClassPeriod,
      required this.subjectId,
      required this.subjectName});
  factory DataItems.fromJson(Map<String, dynamic> json) {
    return DataItems(
        description: json['description'] ?? '',
        id: json['id'] ?? 0,
        date: json['date'] ?? '',
        numberOfClassPeriod: json['number_of_class_period'] ?? '',
        subjectId: json['subject_id'] ?? '',
        subjectName: json['subject_name'] ?? '');
  }
}
