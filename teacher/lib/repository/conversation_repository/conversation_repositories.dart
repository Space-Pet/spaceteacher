import 'package:core/core.dart';
import 'package:teacher/model/conversation_detail_model.dart';
import 'package:teacher/model/conversation_model.dart';
import 'package:teacher/src/services/network_services/api_path.dart';
import 'package:teacher/src/settings/settings.dart';

abstract class ConversationRepository {
  Future<ConversationModel> getConversation(
      {required int userId, required int classId});
  Stream<ConversationDetailModel> getConversationStream(
      {required int userType});
}

class ConversationRepositoryImpl implements ConversationRepository {
  @override
  Future<ConversationModel> getConversation(
      {required int userId, required int classId}) async {
    final token = await Injection.get<Settings>().getAccessToken();
    final res = await ApiClient(
      ApiPath.getConversation,
      headers: {
        'Authorization': 'Bearer $token',
      },
    ).get({}, {"user_id": userId, "class_id": classId});
    if (isNullOrEmpty(res['data'])) return ConversationModel();
    return ConversationModel.fromJson(res['data']);
  }

  @override
  Stream<ConversationDetailModel> getConversationStream(
      {required int userType}) async* {
    // TODO: implement getConversationStream
    throw UnimplementedError();
  }
}
