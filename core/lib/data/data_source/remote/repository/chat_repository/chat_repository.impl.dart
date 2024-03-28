// import 'package:injectable/injectable.dart';

// import '../../../../models/conversation_message.dart';
// import '../../data_repository.dart';
// import 'chat_repository.dart';

// @Singleton(as: ChatRepository)
// class ChatRepositoryImpl with DataRepository implements ChatRepository {
//   @override
//   Future<String?> createChat(ConversationMessage conversationMessage,
//       String iportalId, String partnerId, String bookingCode) async {
//     const query = '''
//           mutation CreateChat(\$object: conversation_insert_input!) {
//         insert_conversation_one(object: \$object) {
//           id
//         }
        
//       }
//     ''';
//     final data = await graphqlProvider.query(
//       query,
//       (data) => data['id'] as String?,
//       'insert_conversation_one',
//       variables: {
//         'object': {
//           'name': bookingCode,
//           'messages': {
//             'data': [
//               {
//                 'content': conversationMessage.content,
//                 'content_data': conversationMessage.contentData?.toJson(),
//                 'type': conversationMessage.type
//               }
//             ]
//           },
//           'members': {
//             'data': [
//               {'user_id': iportalId},
//               {'user_id': partnerId}
//             ]
//           }
//         }
//       },
//     );

//     return data;
//   }

//   @override
//   Future<String?> updateBookingChat(
//     String conversationId,
//     String bookingId,
//   ) async {
//     const query = '''
//         mutation CreateChat(\$_set:  booking_set_input, \$pk_columns: booking_pk_columns_input! ) {
//           update_booking_by_pk(_set:\$_set, pk_columns: \$pk_columns) {
//             id
//           }
//         }
//     ''';
//     final data = await graphqlProvider.query(
//         query, (data) => data['id'] as String?, 'update_booking_by_pk',
//         variables: {
//           '_set': {'conversation_id': conversationId},
//           'pk_columns': {'id': bookingId}
//         });

//     return data;
//   }

//   @override
//   Future<String?> sendChatMessage(
//     String conversationId,
//     ConversationMessage conversationMessage,
//   ) async {
//     const query = '''
//           mutation SendChatMessage(\$object: conversation_message_insert_input!) {
//             insert_conversation_message_one(object: \$object) {
//               id
//             }
//           }
//     ''';
//     final data = await graphqlProvider.query(query,
//         (data) => data['id'] as String?, 'insert_conversation_message_one',
//         variables: {
//           'object': {
//             'content': conversationMessage.content,
//             'content_data': conversationMessage.contentData?.toJson(),
//             'conversation_id': conversationId,
//             'type': conversationMessage.type,
//           }
//         });

//     return data;
//   }

//   @override
//   Stream<List<ConversationMessage>?> onListChatMessageChanged(
//     int limit,
//     int offset,
//     String conversationId,
//   ) {
//     const query = '''
//         subscription SubscribeChat(\$conversation_id: uuid_comparison_exp = {_eq: ""}, \$limit: Int, \$offset: Int,) {
//           conversation_message(where: {conversation_id: \$conversation_id}, limit: \$limit, offset: \$offset,  order_by: {created_at: desc}) {
//             content
//             user_id
//             content_data
//             created_at
//             member {
//               read_at
//             }
//           }
//         }
//     ''';
//     final data = graphqlProvider.subscribeList(
//         query, ConversationMessage.fromJson, 'conversation_message',
//         variables: {
//           'conversation_id': {'_eq': conversationId},
//           'limit': limit,
//           'offset': offset
//         });

//     return data;
//   }

//   @override
//   Future<List<ConversationMessage>?> getChatMessages(
//     int limit,
//     int offset,
//     String conversationId,
//   ) async {
//     const query = '''
//                 query GetChatMessages(\$where: conversation_message_bool_exp,\$limit: Int, \$offset: Int,) {
//           conversation_message(limit: \$limit, offset: \$offset, order_by: {created_at: desc}, where: \$where) {
//             content
//             content_data
//             user_id
//             id
//             created_at
//             type
//             member {
//               read_at
//             }
//           }
//         }
//     ''';
//     final data = await graphqlProvider.queryList(
//         query, ConversationMessage.fromJson, 'conversation_message',
//         variables: {
//           'where': {
//             'conversation_id': {'_eq': conversationId}
//           },
//           'limit': limit,
//           'offset': offset
//         });

//     return data?.reversed.toList();
//   }

//   @override
//   Future<List<QuickMessage>?> getQuickMessages(
//     String type,
//   ) async {
//     const query = '''
//                       query GetQuickMessages(\$type: String){
//             quick_message(where:{type:{_eq:\$type}}, order_by: {priority:asc}) {
//               id
//               content
//               priority
//               type
//             }
            
//           }
//     ''';
//     final data = await graphqlProvider.queryList(
//         query, QuickMessage.fromJson, 'quick_message',
//         variables: {'type': type});

//     return data;
//   }

//   @override
//   Future<void> readChat(
//     String userId,
//     String conversationId,
//   ) async {
//     const query = '''
//             mutation ReadChat(\$pk_columns: conversation_member_pk_columns_input = {conversation_id: "", user_id: ""}, \$_set: conversation_member_set_input = {}) {
//               update_conversation_member_by_pk(pk_columns: \$pk_columns, _set: \$_set) {
//                 conversation_id
//                 user_id
//               }
//             }
//     ''';
//     await graphqlProvider.queryList(
//         query, (p0) {}, 'update_conversation_member_by_pk',
//         variables: {
//           'pk_columns': {'conversation_id': conversationId, 'user_id': userId},
//           '_set': {
//             'read_at': DateTime.now().toUtc().toString() //now()
//           }
//         });

//     return;
//   }

//   @override
//   Future<DateTime?> checkNewChatMessage(
//     String userId,
//     String conversationId,
//   ) async {
//     const query = '''
//          query CheckNewChatMessage(\$conversation_id: uuid = "", \$user_id: String = "") {
//           conversation_member_by_pk(conversation_id: \$conversation_id, user_id: \$user_id) {
//             read_at
//             user_id
//           }
//         }
//     ''';
//     final data = await graphqlProvider.query(
//       query,
//       (p0) => p0['read_at'],
//       'conversation_member_by_pk',
//       variables: {'conversation_id': conversationId, 'user_id': userId},
//     );

//     if (data != null) {
//       return DateTime.parse(data);
//     } else {
//       return null;
//     }
//   }
// }
