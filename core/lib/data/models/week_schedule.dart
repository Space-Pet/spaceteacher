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

  // create fake data
  static WeekSchedule fakeData() {
    return WeekSchedule(
      data: DataWeekSchedule.fakeData(),
      txtBeginDay: '2021-09-06',
      txtClassName: 'Lớp 1A',
      txtEndDay: '2021-09-12',
      txtNextWeek: '2021-09-13',
      txtPreWeek: '2021-08-30',
      txtWeek: '12',
    );
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

  // create fake data
  static DataWeekSchedule fakeData() {
    return DataWeekSchedule(
        mainPlan: [
          const MainPlan(
              classId: '1',
              className: 'Lớp 1A',
              mainPlanBody: 'Nội dung kế hoạch chính',
              mainPlanTitle: 'Kế hoạch chính')
        ],
        detailPlan: List.generate(
          6,
          (index) => DetailPlan(
            planmnDataInWeek: List.generate(
              8,
              (index) => const PlanmnDataInWeek(
                planContent: 'Nội dung kế hoạch',
                planContentDetail: 'Chi tiết nội dung kế hoạch',
                planTeacherId: '1',
                planTeacherName: 'Nguyễn Văn A',
                planTime: '07:00 - 08:00',
              ),
            ),
            planmnNgay: '18-03-2024',
            planmnWeek: 'Monday',
          ),
        ));
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
