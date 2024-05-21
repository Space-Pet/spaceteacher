class LessonModel {
  final int id;
  final int number;
  final String name;
  final String teacherName;
  final String description;
  final String timeStart;
  final String timeEnd;
  final String advice;
  final String fileUrl;
  final String attendance;
  final String room;

  LessonModel({
    required this.id,
    required this.number,
    required this.name,
    required this.teacherName,
    required this.description,
    required this.timeStart,
    required this.timeEnd,
    required this.advice,
    required this.fileUrl,
    required this.attendance,
    required this.room
  });
}

class ExerciseModel {
  final int id;
  final int number;
  final String subjectname;
  final String name;
  final String teacherAva;
  final String description;
  final String duetime;
  final String duedate;
  final String fileUrl;
  final String fileName;

  ExerciseModel({
    required this.id,
    required this.number,
    required this.subjectname,
    required this.name,
    required this.teacherAva,
    required this.description,
    required this.duetime,
    required this.duedate,
    required this.fileUrl,
    required this.fileName,
  });
}
