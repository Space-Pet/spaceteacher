import '../../../../models/conversation_message.dart';
import '../../data_repository.dart';

abstract class ChatRepository with DataRepository {
  Future<String?> createChat(ConversationMessage conversationMessage,
      String iportalId, String partnerId, String bookingCode);
  Future<String?> updateBookingChat(
    String conversationId,
    String bookingId,
  );
  Future<String?> sendChatMessage(
    String conversationId,
    ConversationMessage conversationMessage,
  );
  Stream<List<ConversationMessage>?> onListChatMessageChanged(
    int limit,
    int offset,
    String conversationId,
  );

  Future<List<ConversationMessage>?> getChatMessages(
    int limit,
    int offset,
    String conversationId,
  );

  Future<List<QuickMessage>?> getQuickMessages(
    String type,
  );

  Future<void> readChat(
    String userId,
    String conversationId,
  );

  Future<DateTime?> checkNewChatMessage(
    String userId,
    String conversationId,
  );
}
