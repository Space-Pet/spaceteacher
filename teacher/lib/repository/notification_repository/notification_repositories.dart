import 'package:core/core.dart';
import 'package:teacher/model/notification_detail_model.dart';
import 'package:teacher/model/notification_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class NotificationRepository {
  Future<NotificationModel> getListNotification(
      {String? orderBy, int? schoolId, String? schoolBrand});
  Future<NotificationDetailModel> getDetailNotification(
      {int? notificationId, int? schoolId, String? schoolBrand});
}

class NotificationRepositoryImp implements NotificationRepository {
  @override
  Future<NotificationModel> getListNotification(
      {String? orderBy, int? schoolId, String? schoolBrand}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getListNotifications}?orderBy=$orderBy',
        headers: {
          "Authorization": "Bearer $accessToken",
          "School-Id": "$schoolId",
          "School-Brand": "$schoolBrand"
        },
      ).get();
      if (isNullOrEmpty(res['data'])) return NotificationModel();
      Log.prettyJson(res['data']);
      return NotificationModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name:
              "Get List Notification Error NotificationRepositories -> getListNotification()");
    }
    return NotificationModel();
  }

  @override
  Future<NotificationDetailModel> getDetailNotification(
      {int? notificationId, int? schoolId, String? schoolBrand}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getDetailNotification}$notificationId',
        headers: {
          "Authorization": "Bearer $accessToken",
          "School-Id": "$schoolId",
          "School-Brand": "$schoolBrand"
        },
      ).get();
      if (isNullOrEmpty(res['data'])) return NotificationDetailModel();
      Log.prettyJson(res['data']);
      return NotificationDetailModel.fromJson(res['data']);
    } catch (e) {
      Log.e('$e',
          name:
              "Get Detail Notification Error NotificationRepositories -> getDetailNotification()");
    }
    return NotificationDetailModel();
  }
}
