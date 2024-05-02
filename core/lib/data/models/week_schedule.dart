class WeekSchedule {
  final String txtWeek;
  final String txtBeginDay;
  final String txtEndDay;
  final String txtPreWeek;
  final String txtNextWeek;
  final String txtClassName;
  final DataWeekSchedule data;
  const WeekSchedule(
      {required this.data,
      required this.txtBeginDay,
      required this.txtClassName,
      required this.txtEndDay,
      required this.txtNextWeek,
      required this.txtPreWeek,
      required this.txtWeek});

  factory WeekSchedule.fromJson(Map<String, dynamic> json) {
    final data = DataWeekSchedule.fromJson(json['data']);
    return WeekSchedule(
        data: data,
        txtBeginDay: json['txt_begin_day'] ?? '',
        txtClassName: json['txt_class_name'] ?? '',
        txtEndDay: json['txt_end_day'] ?? '',
        txtNextWeek: json['txt_next_week'] ?? '',
        txtPreWeek: json['txt_pre_week'] ?? '',
        txtWeek: json['txt_week'] ?? '');
  }
}

class DataWeekSchedule {
  final List<MainPlan>? mainPlan;
  final List<DetailPlan>? detailPlan;
  const DataWeekSchedule({this.mainPlan, this.detailPlan});

  factory DataWeekSchedule.fromJson(Map<String, dynamic> json) {
    final detailPlan = (json['detail_plan'] as List<dynamic>?)
        ?.map((e) => DetailPlan.fromJson(e))
        .toList();
    final mainPlan = (json['main_plan'] as List<dynamic>?)
        ?.map((requestMap) => MainPlan.fromJson(requestMap))
        .toList();
    return DataWeekSchedule(
        mainPlan: mainPlan ?? [], detailPlan: detailPlan ?? []);
  }
}

class DetailPlan {
  final String planmnNgay;
  final String planmnWeek;
  final List<PlanmnDataInWeek> planmnDataInWeek;
  const DetailPlan(
      {required this.planmnDataInWeek,
      required this.planmnNgay,
      required this.planmnWeek});
  factory DetailPlan.fromJson(Map<String, dynamic> json) {
    final planmnDataInWeek = (json['PLANMN_DATA_IN_WEEK'] as List<dynamic>?)
        ?.map((e) => PlanmnDataInWeek.fromJson(e))
        .toList();
    return DetailPlan(
        planmnDataInWeek: planmnDataInWeek ?? [],
        planmnNgay: json['PLANMN_NGAY'] ?? '',
        planmnWeek: json['PLAN_WEEK'] ?? '');
  }
}

class PlanmnDataInWeek {
  final String planContent;
  final String planContentDetail;
  final String planTime;
  final String planTeacherId;
  final String planTeacherName;
  const PlanmnDataInWeek(
      {required this.planContent,
      required this.planContentDetail,
      required this.planTeacherId,
      required this.planTeacherName,
      required this.planTime});

  factory PlanmnDataInWeek.fromJson(Map<String, dynamic> json) {
    return PlanmnDataInWeek(
        planContent: json['PLAN_CONTENT'] ?? '',
        planContentDetail: json['PLAN_CONTENT_DETAIL'] ?? '',
        planTeacherId: json['PLAN_TEACHER_ID'] ?? '',
        planTeacherName: json['PLAN_TEACHER_NAME'] ?? '',
        planTime: json['PLAN_TIME'] ?? '');
  }
}

class MainPlan {
  final String? classId;
  final String? className;
  final String? mainPlanTitle;
  final String? mainPlanBody;
  const MainPlan(
      {required this.classId,
      required this.className,
      required this.mainPlanBody,
      required this.mainPlanTitle});
  factory MainPlan.fromJson(Map<String, dynamic> json) {
    return MainPlan(
        classId: json['CLASS_ID'] ?? '',
        className: json['CLASS_NAME'] ?? '',
        mainPlanBody: json['MAIN_PLAN_TITLE'] ?? '',
        mainPlanTitle: json['MAIN_PLAN_BODY'] ?? '');
  }
}
