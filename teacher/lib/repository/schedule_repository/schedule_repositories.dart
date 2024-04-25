import 'package:core/core.dart';
import 'package:teacher/model/list_schedule_model.dart';
import 'package:teacher/model/schedule_model.dart';
import 'package:teacher/model/week_project_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class ScheduleRepository {
  Future<ScheduleModel> getSchedule({String? userKey, String? txtDate});
  Future<WeekProjectModel> getWeekProject({String? userKey, String? txtDate});
  Future<ListScheduleModel> getListSchedule({int? schoolId, String? learnYear});
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  @override
  Future<ScheduleModel> getSchedule({String? userKey, String? txtDate}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getSchedulesStudent}?act=timetable&user_key=$userKey&txt_date=$txtDate',
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get();

      if (isNullOrEmpty(res)) return ScheduleModel();

      return ScheduleModel.fromJson(res);
    } catch (e) {
      Log.e('$e',
          name: 'Get Schedule Error ScheduleRepository -> getSchedule()');
    }
    return ScheduleModel();
  }

  @override
  Future<WeekProjectModel> getWeekProject(
      {String? userKey, String? txtDate}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getSchedulesStudent}?act=weeklyplan&user_key=$userKey&txt_date=$txtDate',
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get();

      if (isNullOrEmpty(res)) return WeekProjectModel();

      return WeekProjectModel.fromJson(res);
    } catch (e) {
      Log.e('$e',
          name:
              'Get Week Project Error ScheduleRepository -> getWeekProject()');
    }
    return WeekProjectModel();
  }

  @override
  Future<ListScheduleModel> getListSchedule(
      {int? schoolId, String? learnYear}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        '${ApiPath.getSchedulesStudent}?act=list_date_timetable&school_id=$schoolId&learn_year=$learnYear',
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get();

      if (isNullOrEmpty(res)) return ListScheduleModel();

      return ListScheduleModel.fromJson(res);
    } catch (e) {
      Log.e('$e',
          name:
              'Get List Schedule Error ScheduleRepository -> getListSchedule()');
    }

    return ListScheduleModel();
  }
}
