import 'package:core/core.dart';
import 'package:teacher/model/leave_model.dart';
import 'package:teacher/model/user_info.dart';
import 'package:teacher/src/services/network_services/api_client.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class LeaveRepository {
  Future<List<LeaveModel>> getLeave({required UserInfo userInfo});
  Future<List<LeaveModel>> getHistoryLeave(
      {required UserInfo userInfo, required String date});
  Future<LeaveModel> getDatailLeave(
      {required int id, required UserInfo userInfo});
}

class LeaveRepositoryImpl implements LeaveRepository {
  @override
  Future<List<LeaveModel>> getLeave({required UserInfo userInfo}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        ApiPath.getLeave,
        headers: {
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpdGVzdC1pcG9ydGFsLm5oZy52blwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE3MTIwMjQ1MzQsIm5iZiI6MTcxMjAyNDUzNCwianRpIjoiZTdrbVNJZXNHSUFDZzJ4eSIsInN1YiI6ODEsInBydiI6ImFhOTFkNzIxZTljYTA5NGQ1Y2I5OWZhYzFiY2IwNmQ5MTQ2ZmFjYzciLCJmdWxsX25hbWUiOiJOZ3V5XHUxZWM1biBWXHUwMTAzbiBCXHUxZWFmYyIsImVtYWlsIjoiYmFjbnYuYmFyaWFAdWthLmVkdS52biIsInVzZXJfa2V5IjoiYmFjbnYudWthYmFyaWEiLCJ1c2VyX2lkIjoxMDA4ODMyMCwic2Nob29sX2lkIjoxMjUsInR5cGUiOjEsInB1cGlsX2lkIjowLCJwYXJlbnRfbmFtZSI6IiIsImZhbmRtX2lkIjowLCJmYXRoZXJfbmFtZSI6IiIsInNjaG9vbF9icmFuZCI6InVrYSIsInRlYWNoZXJfaWQiOjEwMDA0NTkxfQ.vNtLy0Gbpf3OjH14Q9TCy3-ZzXN6aEl5ww_fBhr7tC0",
          "School_Id": 125,
          "School_Brand": 'uka',
        },
      ).get();
      final List<dynamic> data = res['data']['data'];
      return data.map((json) => LeaveModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<LeaveModel>> getHistoryLeave(
      {required UserInfo userInfo, required String date}) async {
    try {
      final String accessToken =
          await Injection.get<Settings>().getAccessToken() ?? "";
      final res = await ApiClient(
        '${ApiPath.getLeave}?start_date=$date',
        headers: {
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpdGVzdC1pcG9ydGFsLm5oZy52blwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE3MTIwMjQ1MzQsIm5iZiI6MTcxMjAyNDUzNCwianRpIjoiZTdrbVNJZXNHSUFDZzJ4eSIsInN1YiI6ODEsInBydiI6ImFhOTFkNzIxZTljYTA5NGQ1Y2I5OWZhYzFiY2IwNmQ5MTQ2ZmFjYzciLCJmdWxsX25hbWUiOiJOZ3V5XHUxZWM1biBWXHUwMTAzbiBCXHUxZWFmYyIsImVtYWlsIjoiYmFjbnYuYmFyaWFAdWthLmVkdS52biIsInVzZXJfa2V5IjoiYmFjbnYudWthYmFyaWEiLCJ1c2VyX2lkIjoxMDA4ODMyMCwic2Nob29sX2lkIjoxMjUsInR5cGUiOjEsInB1cGlsX2lkIjowLCJwYXJlbnRfbmFtZSI6IiIsImZhbmRtX2lkIjowLCJmYXRoZXJfbmFtZSI6IiIsInNjaG9vbF9icmFuZCI6InVrYSIsInRlYWNoZXJfaWQiOjEwMDA0NTkxfQ.vNtLy0Gbpf3OjH14Q9TCy3-ZzXN6aEl5ww_fBhr7tC0",
          "School_Id": 125,
          "School_Brand": 'uka',
        },
      ).get();
      final List<dynamic> data = res['data']['data'];
      return data.map((json) => LeaveModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<LeaveModel> getDatailLeave(
      {required int id, required UserInfo userInfo}) async {
    final String accessToken =
        await Injection.get<Settings>().getAccessToken() ?? "";
    final res = await ApiClient(
      '${ApiPath.getDetailLeave}?id=1&class_id=59965',
      headers: {
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpdGVzdC1pcG9ydGFsLm5oZy52blwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE3MTIwMjQ1MzQsIm5iZiI6MTcxMjAyNDUzNCwianRpIjoiZTdrbVNJZXNHSUFDZzJ4eSIsInN1YiI6ODEsInBydiI6ImFhOTFkNzIxZTljYTA5NGQ1Y2I5OWZhYzFiY2IwNmQ5MTQ2ZmFjYzciLCJmdWxsX25hbWUiOiJOZ3V5XHUxZWM1biBWXHUwMTAzbiBCXHUxZWFmYyIsImVtYWlsIjoiYmFjbnYuYmFyaWFAdWthLmVkdS52biIsInVzZXJfa2V5IjoiYmFjbnYudWthYmFyaWEiLCJ1c2VyX2lkIjoxMDA4ODMyMCwic2Nob29sX2lkIjoxMjUsInR5cGUiOjEsInB1cGlsX2lkIjowLCJwYXJlbnRfbmFtZSI6IiIsImZhbmRtX2lkIjowLCJmYXRoZXJfbmFtZSI6IiIsInNjaG9vbF9icmFuZCI6InVrYSIsInRlYWNoZXJfaWQiOjEwMDA0NTkxfQ.vNtLy0Gbpf3OjH14Q9TCy3-ZzXN6aEl5ww_fBhr7tC0",
        "School_Id": 125,
        "School_Brand": 'uka',
      },
    ).get();
    return LeaveModel.fromJson(res['data']);
  }
}
