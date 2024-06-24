class RegisterNoteBookTeacher {
  final String userId;
  final String teacherId;
  final String teacherFullname;
  final String date;
  final String week;
  final String beginDay;
  final String endDay;
  final String preWeek;
  final String nextWeek;
  final String status;
  final String? statusNote;
  final List<WeeklyLessonTeacher> weeklyLessonData;

  const RegisterNoteBookTeacher({
    required this.userId,
    required this.teacherId,
    required this.teacherFullname,
    required this.date,
    required this.week,
    required this.beginDay,
    required this.endDay,
    required this.preWeek,
    required this.nextWeek,
    required this.status,
    this.statusNote,
    required this.weeklyLessonData,
  });

  factory RegisterNoteBookTeacher.fromJson(Map<String, dynamic> json) {
    final weeklyLessonData = <WeeklyLessonTeacher>[];
    if (json['weeklylesson_data'] != null) {
      for (var element in json['weeklylesson_data']) {
        final lesson = WeeklyLessonTeacher.fromJson(element);
        weeklyLessonData.add(lesson);
      }
    }
    return RegisterNoteBookTeacher(
      userId: json['user_id'] ?? '',
      teacherId: json['teacher_id'] ?? '',
      teacherFullname: json['teacher_fullname'] ?? '',
      date: json['txt_date'] ?? '',
      week: json['txt_week'] ?? '',
      beginDay: json['txt_begin_day'] ?? '',
      endDay: json['txt_end_day'] ?? '',
      preWeek: json['txt_pre_week'] ?? '',
      nextWeek: json['txt_next_week'] ?? '',
      status: json['status'] ?? '',
      statusNote: json['status_note'],
      weeklyLessonData: weeklyLessonData,
    );
  }
}

class WeeklyLessonTeacher {
  final DateInfo ngay;
  final List<LessonDataTeacher> data;

  const WeeklyLessonTeacher({
    required this.ngay,
    required this.data,
  });

  factory WeeklyLessonTeacher.fromJson(Map<String, dynamic> json) {
    final data = <LessonDataTeacher>[];
    if (json['Data'] != null) {
      for (var element in json['Data']) {
        final lessonData = LessonDataTeacher.fromJson(element);
        data.add(lessonData);
      }
    }
    return WeeklyLessonTeacher(
      ngay: DateInfo.fromJson(json['Ngay']),
      data: data,
    );
  }
}

class DateInfo {
  final int date;
  final String day;

  const DateInfo({
    required this.date,
    required this.day,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      date: json['Date'] ?? 0,
      day: json['Day'] ?? '',
    );
  }
}

class LessonDataTeacher {
  final String lessonId;
  final String? lessonName;
  final String subjectId;
  final String subjectName;
  final String? lessonNote;
  final String? danDoBaoBai;
  final String? fileBaoBai;
  final String? fileBaoBaiDomain;
  final String? linkBaoBai;
  final String? hanNopBaoBai;
  final String teacherId;
  final String teacherName;
  final String teacherImg;
  final String tietNum;
  final String tietStatus;
  final String tietStatusNote;
  final List<LessonRankTeacher> lessonRank;

  const LessonDataTeacher({
    required this.lessonId,
    this.lessonName,
    required this.subjectId,
    required this.subjectName,
    this.lessonNote,
    this.danDoBaoBai,
    this.fileBaoBai,
    this.fileBaoBaiDomain,
    this.linkBaoBai,
    this.hanNopBaoBai,
    required this.teacherId,
    required this.teacherName,
    required this.teacherImg,
    required this.tietNum,
    required this.tietStatus,
    required this.tietStatusNote,
    required this.lessonRank,
  });

  factory LessonDataTeacher.fromJson(Map<String, dynamic> json) {
    final lessonRank = <LessonRankTeacher>[];
    if (json['lesson_rank'] != null) {
      for (var element in json['lesson_rank']) {
        final rank = LessonRankTeacher.fromJson(element);
        lessonRank.add(rank);
      }
    }
    return LessonDataTeacher(
      lessonId: json['lesson_id'] ?? '',
      lessonName: json['lesson_name'],
      subjectId: json['subject_id'] ?? '',
      subjectName: json['subject_name'] ?? '',
      lessonNote: json['lesson_note'] ?? '',
      danDoBaoBai: json['dan_do_bao_bai'],
      fileBaoBai: json['file_bao_bai'],
      fileBaoBaiDomain: json['file_bao_bai_domain'],
      linkBaoBai: json['link_bao_bai'],
      hanNopBaoBai: json['han_nop_bao_bai'],
      teacherId: json['teacher_id'] ?? '',
      teacherName: json['teacher_name'] ?? '',
      teacherImg: json['teacher_img'] ?? '',
      tietNum: json['tiet_num'] ?? '',
      tietStatus: json['tiet_status'] ?? '',
      tietStatusNote: json['tiet_status_note'] ?? '',
      lessonRank: lessonRank,
    );
  }
}

class LessonRankTeacher {
  final int lessonRankKey;
  final String lessonRankName;
  final bool active;

  const LessonRankTeacher({
    required this.lessonRankKey,
    required this.lessonRankName,
    required this.active,
  });

  factory LessonRankTeacher.fromJson(Map<String, dynamic> json) {
    return LessonRankTeacher(
      lessonRankKey: json['lesson_rank_key'] ?? 0,
      lessonRankName: json['lesson_rank_name'] ?? '',
      active: json['active'] == 1,
    );
  }
}
