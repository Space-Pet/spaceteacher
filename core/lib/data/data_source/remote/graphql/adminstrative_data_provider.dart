import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../models/adminstrative.dart';
import '../utils.dart';

const String _getAdminstrativeData = '''
  query MyQuery {
  country(where: {iso: {_eq: VN}}) {
    iso
    iso3
    name
    nice_name
    num_code
    phone_code
    provinces(order_by: {name: asc}) {
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
} ''';

class AdministrativeDatateacher {
  GraphQLClient? _graphQLClient;

  AdministrativeDatateacher(GraphQLClient client) {
    _graphQLClient = client;
  }

  Future<List<Province>?> getAdminstrativeData() async {
    _graphQLClient?.cache.store.reset();
    final result = await _graphQLClient?.query(
      QueryOptions(document: parseNode(_getAdminstrativeData)),
    );
    if (result!.hasException) {
      throw result.exception!;
    }

    final returning = (result.data?['country'] as List).first;

    if (returning == null || returning.isEmpty) {
      return null;
    }

    return AdministrativeResponse.fromJson(returning).provinces;
  }
}
