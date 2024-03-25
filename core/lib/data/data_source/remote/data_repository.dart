import '../../../di/di.dart';
import '../../../presentation/base/graphql_provider.dart';
import '../local/preferences_helper/preferences_helper.dart';
import 'app_api_service.dart';

mixin DataRepository {
  late final graphqlProvider = GraphqlProvider(
    injector.get<AppApiService>().graphQLClient,
  );

  late final preferenceHelper = injector.get<PreferencesHelper>();
}
