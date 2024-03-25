import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../../common/utils.dart';
import '../../../../models/adminstrative.dart';
import '../../../../models/app_setting.dart';
import '../../../../models/booking_setting.dart';
import '../../data_repository.dart';
import 'config_repository.dart';

@Singleton(as: ConfigRepository)
class ConfigRepositoryImpl with DataRepository implements ConfigRepository {
  @override
  Future<List<Province>> getProvincesData() async {
    const query = '''
    query MyQuery {
      province(order_by: {name: asc}) {
        code
        country_code
        name
        districts(order_by: {name: asc}) {
          code
          country_code
          name
          province_code
          wards(order_by: {name: asc}) {
            code
            country_code
            district_code
            name
            province_code
          }
        }
      }
    }
    ''';
    final adminstrativeData = await graphqlProvider.queryList(
      query,
      Province.fromJson,
      'province',
    );
    return adminstrativeData ?? [];
  }

  @override
  Future<List<BookingSetting>?> getBookingSettings() {
    const query = '''
    query GetSettings {
      booking_setting {
        id
        value 
      }
    }''';
    return graphqlProvider.queryList(
      query,
      BookingSetting.fromJson,
      'booking_setting',
    );
  }

  @override
  Future<AppSetting?> getAppSettings() async {
    const query = '''
    query GetSettings {
      app_setting {
        app_settings
      }
    }''';
    final settings = await graphqlProvider.queryList(
      query,
      AppSettingResponse.fromJson,
      'app_setting',
    );
    return settings.firstOrNull?.appSettings;
  }

  @override
  Future<bool?> sendFeedback(String content) async {
    const query = '''
    mutation MyMutation(\$comment: String) {
      insert_user_feedback(objects: {comment: \$comment}) {
        affected_rows
      }
    }''';

    final result = await graphqlProvider.mutate(
      query,
      (retturning) => retturning['affected_rows'] != null,
      'insert_user_feedback',
      variables: {
        'comment': content,
      },
    );
    return result;
  }

  @override
  Future<List<TermsOfUse>?> getTermsOfUseData() async {
    const query = '''
      query GetTermOfUse {
        term_of_use(order_by: {created_at: desc}) {
          content
          id
          image_url
          name
          status
          description
          updated_at
        }
      }
  
    ''';
    final result = await graphqlProvider.queryList(
      query,
      TermsOfUse.fromJson,
      'term_of_use',
    );
    return result;
  }
}
