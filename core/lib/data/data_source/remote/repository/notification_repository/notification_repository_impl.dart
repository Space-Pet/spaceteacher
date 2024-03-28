// part of 'notification_repository.dart';

// const _notiProps = '''
// id
// data
// contents
// subject_type
// subject_id
// read
// send_after
// headings
// ''';

// @Singleton(as: NotificationRepository)
// class NotificationRepositoryImpl
//     with DataRepository
//     implements NotificationRepository {
//   @override
//   Future<List<NotificationModel>> getNewNotificationiportal(
//     int offset,
//     int limit,
//   ) async {
//     const query = '''
//     query NotificationList(
//       \$limit: Int
//       \$offset: Int
//       \$where: notification_personal_result_bool_exp
//     ) {
//       notification_personal_view(
//         limit: \$limit
//         offset: \$offset
//         order_by: { send_after: desc }
//         where: \$where
//       ) {
//         $_notiProps
//       }
//     }
//     ''';
//     final data = await graphqlProvider.queryList(
//       query,
//       NotificationModel.fromJson,
//       'notification_personal_view',
//       variables: {
//         'limit': limit,
//         'offset': offset,
//         'where': {
//           'subject_type': {
//             '_in': ['post', 'new_promotion']
//           },
//         }
//       },
//     );
//     return data ?? [];
//   }

//   @override
//   Future<List<NotificationModel>> getNewNotificationPartner(
//     int offset,
//     int limit,
//   ) async {
//     const query = '''
//     query NotificationList(
//       \$limit: Int
//       \$offset: Int
//       \$where: notification_personal_result_bool_exp
//     ) {
//       notification_personal_view(
//         limit: \$limit
//         offset: \$offset
//         order_by: { send_after: desc }
//         where: \$where
//       ) {
//         $_notiProps
//       }
//     }
//     ''';
//     final data = await graphqlProvider.queryList(
//       query,
//       NotificationModel.fromJson,
//       'notification_personal_view',
//       variables: {
//         'limit': limit,
//         'offset': offset,
//         'where': {
//           'subject_type': {
//             '_in': ['post']
//           },
//         }
//       },
//     );
//     return data ?? [];
//   }

//   @override
//   Future<NotificationModel?> getNotificationDetail(
//     String id,
//   ) async {
//     const query = '''
//     query NotificationList(
//       \$where: notification_personal_result_bool_exp
//     ) {
//       notification_personal_view(
//         where: \$where
//       ) {
//         $_notiProps
//       }
//     }
//     ''';
//     final data = await graphqlProvider.queryList(
//       query,
//       NotificationModel.fromJson,
//       'notification_personal_view',
//       variables: {
//         'where': {
//           'id': {
//             '_eq': id,
//           }
//         }
//       },
//     );
//     return data?[0];
//   }

//   @override
//   Future<List<NotificationModel>> getWorkingNotification(
//     int offset,
//     int limit,
//   ) async {
//     const query = '''
//     query NotificationList(
//       \$limit: Int
//       \$offset: Int
//       \$where: notification_personal_result_bool_exp
//     ) {
//       notification_personal_view(
//         limit: \$limit
//         offset: \$offset
//         order_by: { send_after: desc }
//         where: \$where
//       ) {
//         $_notiProps
//       }
//     }
//     ''';
//     final data = await graphqlProvider.queryList(
//       query,
//       NotificationModel.fromJson,
//       'notification_personal_view',
//       variables: {
//         'limit': limit,
//         'offset': offset,
//         'where': {
//           'subject_type': {
//             '_nin': ['post', 'general', 'new_chat_message', 'new_promotion']
//           },
//         }
//       },
//     );
//     return data ?? [];
//   }

//   @override
//   Future<bool> markReadNotificaiton(String? id, String userId) async {
//     const query = '''
//     mutation MarkAsReadNotification(\$where: notification_user_bool_exp!) {
//       update_notification_user(where: \$where, _set: { read: true }) {
//         affected_rows
//       }
//     }
//     ''';
//     final data = await graphqlProvider.mutate(
//       query,
//       (returning) {
//         return returning['update_notification_user'] != null;
//       },
//       'update_notification_user',
//       variables: {
//         'where': {
//           if (id != null) 'notification_id': {'_eq': id},
//           'user_id': {'_eq': userId},
//           'notification': {
//             'subject_type': {
//               '_nin': ['post', 'general']
//             },
//           }
//         }
//       },
//     );
//     return data;
//   }

//   @override
//   Future<bool> markReadNewsNotificaiton(String? id, String userId) {
//     var keyPath = '';
//     var query = '';
//     var variables = <String, dynamic>{};
//     if (id == null) {
//       keyPath = 'insert_user_notification_setting';
//       query = r'''mutation MarkAllAsReadNewsNotification(
//         $objects: [user_notification_setting_insert_input!]!
//       ) {
//         insert_user_notification_setting(
//           objects: $objects, 
//           on_conflict: {constraint: user_notification_setting_pkey, update_columns: read_all}
//         ) {
//           affected_rows
//         }
//       }''';
//       variables = {
//         'objects': {
//           'read_all': 'now()',
//         }
//       };
//     } else {
//       keyPath = 'insert_notification_user_one';
//       query = r'''mutation MarkAsReadNewsNotification(
//         $object: notification_user_insert_input!
//       ) {
//         insert_notification_user_one(
//           object: $object, 
//           on_conflict: {constraint: notification_user_pkey, update_columns: read}
//         ) {
//           user_id
//         }
//       }''';
//       variables = {
//         'object': {
//           'notification_id': id,
//           'read': true,
//         }
//       };
//     }
//     return graphqlProvider.mutate(
//       query,
//       (returning) {
//         return returning[keyPath] != null;
//       },
//       keyPath,
//       variables: variables,
//     );
//   }

//   @override
//   Future<int?> getNumOfUnreadNotifications() async {
//     const query = '''
//      query NotificationList(
//       \$where: notification_personal_result_bool_exp
//     ) {
//       notification_personal_view(
//         order_by: { send_after: desc }
//         where: \$where
//       ) {
//       id
//         read 
//       }
//     }
//     ''';
//     final data = await graphqlProvider.queryList(
//       query,
//       NotificationModel.fromJson,
//       'notification_personal_view',
//       variables: {
//         'where': {
//           'read': {'_eq': false},
//           'subject_type': {
//             '_nin': ['new_chat_message', 'general']
//           }
//         }
//       },
//     );
//     return data?.length ?? 0;
//   }

//   @override
//   Future<int?> getNumOfUnreadNotificationsPartner() async {
//     const query = '''
//      query NotificationList(
//       \$where: notification_personal_result_bool_exp
//     ) {
//       notification_personal_view(
//         order_by: { send_after: desc }
//         where: \$where
//       ) {
//         id
//         read 
//       }
//     }
//     ''';
//     final data = await graphqlProvider.queryList(
//       query,
//       NotificationModel.fromJson,
//       'notification_personal_view',
//       variables: {
//         'where': {
//           'read': {'_eq': false},
//           'subject_type': {
//             '_nin': ['new_chat_message', 'general', 'new_promotion']
//           }
//         }
//       },
//     );
//     return data?.length ?? 0;
//   }
// }
