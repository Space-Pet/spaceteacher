import 'package:core/core.dart';
import 'package:teacher/model/menu_in_week_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class MenuRepository {
  Future<MenuInWeekModel> getMenuInWeek({String? userKey, String? date});
  Future<String> absenceApplication({
    String? content,
    String? pupilId,
    String? startDate,
    String? endDate,
    String? schoolId,
    String? schoolBrand,
  });
}

class MenuRepositoryImpl implements MenuRepository {
  @override
  Future<MenuInWeekModel> getMenuInWeek({String? userKey, String? date}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();
      final res = await ApiClient(ApiPath.getMenuInWeek, headers: {
        'Parter-Token': 'Bearer $accessToken',
        'act': 'weeklymenu',
        'type': 'json',
        'user_key': userKey,
        'txt_date': date,
      }).get();
      if (isNullOrEmpty(res)) return MenuInWeekModel();

      return MenuInWeekModel.fromJson(res);
    } catch (e) {
      Log.e('$e',
          name: 'Get Menu In Week Error MenuRepository -> getMenuInWeek()');
    }

    return MenuInWeekModel();
  }

  @override
  Future<String> absenceApplication(
      {String? content,
      String? pupilId,
      String? startDate,
      String? endDate,
      String? schoolId,
      String? schoolBrand}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        ApiPath.postAbsenceApplication,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'School-Id': schoolId,
          'School-Brand': schoolBrand,
        },
      ).post({
        'content': content,
        'pupil_id': pupilId,
        'start_date': startDate,
        'end_date': endDate,
      });

      if (isNullOrEmpty(res['status'])) return 'Failure';

      return res['status'];
    } catch (e) {
      Log.e('$e',
          name:
              'Absence Application Error MenuRepository -> absenceApplication()');
    }
    return 'Failure';
  }
}
