import 'package:graphql_flutter/graphql_flutter.dart';

import '../../common/utils.dart';
import '../../data/data_source/remote/utils.dart';

class GraphqlProvider {
  final GraphQLClient _graphQLClient;
  final int timeout = 120;

  GraphqlProvider(this._graphQLClient);

  Future<T?> query<T>(
    String query,
    T Function(Map<String, dynamic>) parseFunction,
    String? keyPath, {
    Map<String, dynamic> variables = const {},
  }) async {
    _graphQLClient.cache.store.reset();
    final result = await _graphQLClient
        .query(
          QueryOptions(
            document: parseNode(
              query,
            ),
            variables: variables,
          ),
        )
        .timeout(
          Duration(
            seconds: timeout,
          ),
        );

    if (result.hasException) {
      throw result.exception!;
    }
    LogUtils.d('${result.data}');

    final returning = (keyPath != null) ? result.data![keyPath] : result.data;
    return returning != null ? parseFunction.call(returning) : null;
  }

  Future<List<T>?> queryList<T>(
    String query,
    T Function(Map<String, dynamic>) parseFunction,
    String? keyPath, {
    Map<String, dynamic> variables = const {},
  }) async {
    _graphQLClient.cache.store.reset();
    final result = await _graphQLClient
        .query(
          QueryOptions(
            document: parseNode(
              query,
            ),
            variables: variables,
          ),
        )
        .timeout(
          Duration(
            seconds: timeout,
          ),
        );
    if (result.hasException) {
      throw result.exception!;
    }

    final returning = _dataByPath(result.data, keyPath);
    LogUtils.d('$returning');

    if (returning is List) {
      return returning.map((e) => parseFunction(e)).toList();
    }
    return null;
  }

  Future<T> mutate<T>(
    String query,
    T Function(Map<String, dynamic>) parseFunction,
    String? keyPath, {
    Map<String, dynamic> variables = const {},
  }) async {
    _graphQLClient.cache.store.reset();
    final result = await _graphQLClient
        .mutate(
          MutationOptions(
            document: parseNode(
              query,
            ),
            variables: variables,
          ),
        )
        .timeout(
          Duration(
            seconds: timeout,
          ),
        );
    if (result.hasException) {
      throw result.exception!;
    }
    // LogUtils.d('${result.data}');
    final returning = _dataByPath(result.data, keyPath);
    return parseFunction.call(returning);
  }

  Stream<T> subscribe<T>(String document,
      T Function(Map<String, dynamic>) parseFunction, String? keyPath) {
    LogUtils.d('Subscription $document');
    _graphQLClient
        .subscribe(SubscriptionOptions(document: gql(document)))
        .listen((event) {
      if (event.hasException) {
        LogUtils.e('Subscription $document failed ${event.exception}');
      }
    });
    return _graphQLClient
        .subscribe(SubscriptionOptions(document: parseNode(document)))
        .where((event) => event.data != null)
        .map((event) {
      final data = event.data?[keyPath];
      return data.map((e) => parseFunction(e)).first;
    });
  }

  Stream<List<T>> subscribeList<T>(
    String document,
    T Function(Map<String, dynamic>) parseFunction,
    String? keyPath, {
    Map<String, dynamic> variables = const {},
  }) {
    _graphQLClient.queryManager.cache.store.reset();

    _graphQLClient.cache.store.reset();

    return _graphQLClient
        .subscribe(SubscriptionOptions(
      document: parseNode(document),
      variables: variables,
      cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      fetchPolicy: FetchPolicy.networkOnly,
    ))
        .where((event) {
      if (event.hasException) {
        LogUtils.e(
          event.exception,
          'Subscription: [$keyPath] - [$T]',
        );
      }

      return event.data != null;
    }).map((event) {
      final data = event.data?[keyPath];

      LogUtils.d(
        data.toString().length > 3000 ? data.toString() : data,
        'Subscription: [$keyPath] - [$T]',
      );

      return [...?data.map((e) => parseFunction(e))];
    });
  }

  dynamic _dataByPath(Map<String, dynamic>? data, String? path) {
    if (data == null || path == null) {
      return data;
    }
    final keys = path.split('.');
    dynamic result = data;
    for (final key in keys) {
      result = result[key];
    }
    return result;
  }
}
