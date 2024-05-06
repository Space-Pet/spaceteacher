import 'package:core/core.dart';
import 'package:teacher/model/bus_route_model.dart';
import 'package:teacher/model/bus_schedule_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class BusRepository {
  Future<List<BusRoutesModel>> getListBusRoute(
      {int? schoolId, String? schoolBrand});
  Future<BusScheduleModel> getListBusSchedule(
      {int? schoolId, String? schoolBrand, String? startDate, String? endDate});
}

class BusRepositoryImpl extends BusRepository {
  @override
  Future<List<BusRoutesModel>> getListBusRoute(
      {int? schoolId, String? schoolBrand}) async {
    final String accessToken =
        await Injection.get<Settings>().getAccessToken() ?? "";
    final res = await ApiClient(
      ApiPath.getListBusRoutes,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'School-Id': '$schoolId',
        'School-Brand': '$schoolBrand',
      },
    ).get();

    if (isNullOrEmpty(res['data']['data'])) return <BusRoutesModel>[];
    return res['data']['data']
        .map<BusRoutesModel>((e) => BusRoutesModel.fromJson(e))
        .toList();
  }

  @override
  Future<BusScheduleModel> getListBusSchedule(
      {String? startDate,
      String? endDate,
      int? schoolId,
      String? schoolBrand}) async {
    final String accessToken =
        await Injection.get<Settings>().getAccessToken() ?? "";
    final res = await ApiClient(
      ApiPath.getListBusSchedule,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'School-Id': schoolId,
        'School-Brand': schoolBrand,
      },
    ).get({
      'start_date': startDate,
      'end_date': endDate,
    });
    if (isNullOrEmpty(res['data'])) return BusScheduleModel();

    return BusScheduleModel.fromJson(res['data']);
  }
}
