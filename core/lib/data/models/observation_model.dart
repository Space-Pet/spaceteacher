import 'dart:convert';

class ObservationModel {
  ObservationModel({
    required this.userId,
    required this.txtDate,
    this.data,
  });

  final String userId;
  final String txtDate;
  final List<ObservationData>? data;

  ObservationModel copyWith({
    String? userId,
    String? txtDate,
    List<ObservationData>? data,
  }) {
    return ObservationModel(
      userId: userId ?? this.userId,
      txtDate: txtDate ?? this.txtDate,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'txt_data': txtDate,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ObservationModel.fromMap(Map<String, dynamic> map) {
    return ObservationModel(
      userId: map['user_id'] as String,
      txtDate: map['txt_data'] as String,
      data: List<ObservationData>.from(map['data']
          ?.map((x) => ObservationData.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ObservationModel.fromJson(String source) =>
      ObservationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ObservavtionModel(user_id: $userId, txt_data: $txtDate, data: $data)';
}

class ObservationData {
  final String schooldId;
  final String lessonNum;
  final String classId;
  final String className;
  final String roomId;
  final String roomName;
  final String subjectId;
  final String subjectName;
  final String teacherId;
  final String teacherFullname;
  final String weekDay;

  ObservationData({
    required this.schooldId,
    required this.lessonNum,
    required this.classId,
    required this.className,
    required this.roomId,
    required this.roomName,
    required this.subjectId,
    required this.subjectName,
    required this.teacherId,
    required this.teacherFullname,
    required this.weekDay,
  });

  ObservationData copyWith({
    String? schooldId,
    String? lessonNum,
    String? classId,
    String? className,
    String? roomId,
    String? roomName,
    String? subjectId,
    String? subjectName,
    String? teacherId,
    String? teacherFullname,
    String? weekDay,
  }) {
    return ObservationData(
      schooldId: schooldId ?? this.schooldId,
      lessonNum: lessonNum ?? this.lessonNum,
      classId: classId ?? this.classId,
      className: className ?? this.className,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      teacherId: teacherId ?? this.teacherId,
      teacherFullname: teacherFullname ?? this.teacherFullname,
      weekDay: weekDay ?? this.weekDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'SCHOOL_ID': schooldId,
      'TIET_NUM': lessonNum,
      'CLASS_ID': classId,
      'CLASS_NAME': className,
      'ROOM_ID': roomId,
      'ROOM_NAME': roomName,
      'SUBJECT_ID': subjectId,
      'SUBJECT_NAME': subjectName,
      'TEACHER_ID': teacherId,
      'TEACHER_FULLNAME': teacherFullname,
      'WEEK_DAY': weekDay,
    };
  }

  factory ObservationData.fromMap(Map<String, dynamic> map) {
    return ObservationData(
      schooldId: map['SCHOOL_ID'] as String,
      lessonNum: map['TIET_NUM'] as String,
      classId: map['CLASS_ID'] as String,
      className: map['CLASS_NAME'] as String,
      roomId: map['ROOM_ID'] as String,
      roomName: map['ROOM_NAME'] as String,
      subjectId: map['SUBJECT_ID'] as String,
      subjectName: map['SUBJECT_NAME'] as String,
      teacherId: map['TEACHER_ID'] as String,
      teacherFullname: map['TEACHER_FULLNAME'] as String,
      weekDay: map['WEEK_DAY'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ObservationData.fromJson(String source) =>
      ObservationData.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ObservationData> fakeData() {
    return List.generate(
      10,
      (index) => ObservationData(
        schooldId: 'schoolId $index',
        lessonNum: 'lessonNum $index',
        classId: 'classId $index',
        className: 'className $index',
        roomId: 'roomId $index',
        roomName: 'roomName $index',
        subjectId: 'subjectId $index',
        subjectName: 'subjectName $index',
        teacherId: 'teacherId $index',
        teacherFullname: 'teacherFullname $index',
        weekDay: 'weekDay $index',
      ),
    );
  }
}
