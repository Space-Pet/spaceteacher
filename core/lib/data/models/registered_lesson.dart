class RegisteredLesson {
  String lessonRegisterId;
  String lessonRegisterDate;
  String lessonRegisterTietNum;
  String lessonRegisterClassId;
  String lessonRegisterClassName;
  String lessonRegisterRoomName;
  String lessonRegisterSubjectId;
  String lessonRegisterSubjectName;
  String lessonRegisterTeacherId;
  String lessonRegisterTeacherName;
  String? lessonRegisterTeacherImg;
  String lessonRegisterLearnYear;
  String? lessonRegisterStatus;

  RegisteredLesson({
    required this.lessonRegisterId,
    required this.lessonRegisterDate,
    required this.lessonRegisterTietNum,
    required this.lessonRegisterClassId,
    required this.lessonRegisterClassName,
    required this.lessonRegisterRoomName,
    required this.lessonRegisterSubjectId,
    required this.lessonRegisterSubjectName,
    required this.lessonRegisterTeacherId,
    required this.lessonRegisterTeacherName,
    this.lessonRegisterTeacherImg,
    required this.lessonRegisterLearnYear,
    this.lessonRegisterStatus,
  });

  factory RegisteredLesson.fromMap(Map<String, dynamic> map) {
    return RegisteredLesson(
      lessonRegisterId: map['lesson_register_id'],
      lessonRegisterDate: map['lesson_register_date'],
      lessonRegisterTietNum: map['lesson_register_tiet_num'],
      lessonRegisterClassId: map['lesson_register_class_id'],
      lessonRegisterClassName: map['lesson_register_class_name'],
      lessonRegisterRoomName: map['lesson_register_room_name'],
      lessonRegisterSubjectId: map['lesson_register_subject_id'],
      lessonRegisterSubjectName: map['lesson_register_subject_name'],
      lessonRegisterTeacherId: map['lesson_register_teacher_id'],
      lessonRegisterTeacherName: map['lesson_register_teacher_name'],
      lessonRegisterTeacherImg: map['lesson_register_teacher_img'],
      lessonRegisterLearnYear: map['lesson_register_learn_year'],
      lessonRegisterStatus: map['lesson_register_status'],
    );
  }

  static List<RegisteredLesson> fakeData() {
    return List.generate(
      6,
      (index) => RegisteredLesson(
        lessonRegisterId: 'lessonRegisterId$index',
        lessonRegisterDate: 'lessonRegisterDate$index',
        lessonRegisterTietNum: 'TietNum$index',
        lessonRegisterClassId: 'lessonRegisterClassId$index',
        lessonRegisterClassName: 'ClassName$index',
        lessonRegisterRoomName: 'RoomName$index',
        lessonRegisterSubjectId: 'lessonRegisterSubjectId$index',
        lessonRegisterSubjectName: 'SubjectName$index',
        lessonRegisterTeacherId: 'lessonRegisterTeacherId$index',
        lessonRegisterTeacherName: 'TeacherName$index',
        lessonRegisterTeacherImg: 'lessonRegisterTeacherImg$index',
        lessonRegisterLearnYear: 'lessonRegisterLearnYear$index',
        lessonRegisterStatus: 'lessonRegisterStatus$index',
      ),
    );
  }
}
