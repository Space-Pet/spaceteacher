import 'dart:io';

import 'package:core/core.dart';
import 'package:teacher/model/register_notebook_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';
import '../../src/services/network_services/api_client.dart';

abstract class RegisterNotebookRepository {
  Future<RegisterNotebookModel> getRegisterNotebookTeacher(
      {String? userKey, String? date});
  Future<RegisterNotebookModel> getRegisterNotebookStudent(
      {String? userKey, String? date});
  Future<RegisterNotebookModel> postRegisterNotebook(
      {String? lessonRank,
      String? danDoBaoBai,
      File? fileBaoBai,
      String? linkBaoBai,
      String? hanNop});

  Future<RegisterNotebookModel> deleteRegisterNotebook(
      {String? userKey, String? lessonId});
}

class RegisterNotebookRepositoryImpl implements RegisterNotebookRepository {
  @override
  Future<RegisterNotebookModel> getRegisterNotebookTeacher(
      {String? userKey, String? date}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        ApiPath.getRegisterNotebookTeacher,
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get({
        'act': 'weeklylesson_teacher',
        'type': 'json',
        'user_key': userKey,
        'date': date,
      });
      if (isNullOrEmpty(res)) return RegisterNotebookModel();
      return RegisterNotebookModel.fromJson(res);
    } catch (e) {
      Log.e(e.toString(),
          name: 'RegisterNotebookRepository -> getRegisterNotebookTeacher()');
    }
    return RegisterNotebookModel();
  }

  @override
  Future<RegisterNotebookModel> getRegisterNotebookStudent(
      {String? userKey, String? date}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(
        ApiPath.getRegisterNotebookStudent,
        headers: {
          'Parter-Token': 'Bearer $accessToken',
        },
      ).get({
        'act': 'weeklylesson',
        'type': 'json',
        'user_key': userKey,
        'date': date,
      });
      if (isNullOrEmpty(res)) return RegisterNotebookModel();
      return RegisterNotebookModel.fromJson(res);
    } catch (e) {
      Log.e(e.toString(),
          name: 'RegisterNotebookRepository -> getRegisterNotebook()');
    }
    return RegisterNotebookModel();
  }

  @override
  Future<RegisterNotebookModel> postRegisterNotebook(
      {String? lessonRank,
      String? danDoBaoBai,
      File? fileBaoBai,
      String? linkBaoBai,
      String? hanNop}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(ApiPath.postRegisterNotebook, headers: {
        'Partner-Token': 'Bearer $accessToken',
      }).post({
        'lesson_rank': lessonRank,
        'dan_do_bao_bai': danDoBaoBai,
        'file_bao_bai': fileBaoBai,
        'link_bao_bai': linkBaoBai,
        'han_nop': hanNop,
      }, {
        'act': 'weeklylesson_insert',
      });
      if (isNullOrEmpty(res)) return RegisterNotebookModel();
      return RegisterNotebookModel.fromJson(res);
    } catch (e) {
      Log.e(e.toString(),
          name: 'RegisterNotebookRepository -> postRegisterNotebook()');
    }
    return RegisterNotebookModel();
  }

  @override
  Future<RegisterNotebookModel> deleteRegisterNotebook(
      {String? userKey, String? lessonId}) async {
    try {
      final accessToken = await Injection.get<Settings>().getAccessToken();

      final res = await ApiClient(ApiPath.postRegisterNotebook, headers: {
        'Partner-Token': 'Bearer $accessToken',
      }).delete({
        'user_key': userKey,
        'lesson_id': lessonId,
      }, {
        'act': 'weeklylesson_delete',
      });
      if (isNullOrEmpty(res)) return RegisterNotebookModel();
      return RegisterNotebookModel.fromJson(res);
    } catch (e) {
      Log.e(e.toString(),
          name: 'RegisterNotebookRepository -> deleteRegisterNotebook()');
    }

    return RegisterNotebookModel();
  }
}
