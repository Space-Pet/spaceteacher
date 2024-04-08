import 'dart:convert';

class Schedule {
  String tkbDateApply;
  String tkbClass;
  List<ScheduleData> tkbData;

  Schedule({
    required this.tkbDateApply,
    required this.tkbClass,
    required this.tkbData,
  });

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      tkbDateApply: map['tkb_date_apply'],
      tkbClass: map['tkb_class'],
      tkbData: List<ScheduleData>.from(
        map['tkb_data']?.map((x) => ScheduleData.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tkb_date_apply': tkbDateApply,
      'tkb_class': tkbClass,
      'tkb_data': List<dynamic>.from(tkbData.map((x) => x.toMap()) ?? []),
    };
  }

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Schedule(tkbDateApply: $tkbDateApply, tkbClass: $tkbClass, tkbData: $tkbData)';
  }

  factory Schedule.empty() =>
      Schedule(tkbDateApply: '', tkbClass: '', tkbData: []);
}

class ScheduleData {
  String date;
  String dateName;
  List<DateSubject> dateSubject;

  ScheduleData({
    required this.date,
    required this.dateName,
    required this.dateSubject,
  });

  factory ScheduleData.fromMap(Map<String, dynamic> map) {
    return ScheduleData(
      date: map['Date'],
      dateName: map['Date_Name'],
      dateSubject: List<DateSubject>.from(
        map['DateSubject']?.map((x) => DateSubject.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Date': date,
      'Date_Name': dateName,
      'DateSubject':
          List<dynamic>.from(dateSubject?.map((x) => x.toMap()) ?? []),
    };
  }

  factory ScheduleData.fromJson(String source) =>
      ScheduleData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ScheduleData(date: $date, dateName: $dateName, dateSubject: $dateSubject)';
  }
}

class DateSubject {
  String? subjectId;
  String? subjectName;
  int? tietNum;
  String? classId;
  String? className;
  String? room;
  String? teacherId;
  String? teacherName;
  String? teacherImg;

  DateSubject({
    this.subjectId,
    this.subjectName,
    this.tietNum,
    this.classId,
    this.className,
    this.room,
    this.teacherId,
    this.teacherName,
    this.teacherImg,
  });

  factory DateSubject.fromMap(Map<String, dynamic> map) {
    return DateSubject(
      subjectId: map['Subjet_Id'],
      subjectName: map['SubjetName'],
      tietNum: map['tiet_num'],
      classId: map['Class_Id'],
      className: map['Class_Name'],
      room: map['Room'],
      teacherId: map['Teacher_Id'],
      teacherName: map['Teacher_Name'],
      teacherImg: map['Teacher_Img'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Subjet_Id': subjectId,
      'SubjetName': subjectName,
      'tiet_num': tietNum,
      'Class_Id': classId,
      'Class_Name': className,
      'Room': room,
      'Teacher_Id': teacherId,
      'Teacher_Name': teacherName,
      'Teacher_Img': teacherImg,
    };
  }

  factory DateSubject.fromJson(String source) =>
      DateSubject.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DateSubject(subjectId: $subjectId, subjectName: $subjectName, tietNum: $tietNum, classId: $classId, className: $className, room: $room, teacherId: $teacherId, teacherName: $teacherName, teacherImg: $teacherImg)';
  }
}
