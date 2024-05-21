import 'package:core/core.dart';
import 'package:core/presentation/screens/domain/domain_saver.dart';

class ApiClient {
  final String path;
  final Map<String, dynamic>? headers;
  final String? prefix;
  final String? suffix;

  ApiClient(
    this.path, {
    this.headers,
    this.prefix,
    this.suffix,
  });

  ApiClientBase get base => ApiClientBase(
        headers: headers,
        prefix: prefix,
        suffix: suffix,
        domainSaver: Injection.get<DomainSaver>(),
      );
  
  Future<dynamic> get([Map<String, dynamic>? params]) async {
    final domain = await base.domainSaver.getDomain();
    Log.d('ApiClient -> get() -> domain: $domain');
    return base.get(path, params);
  }

  Future<dynamic> post(
    dynamic body, [
    Map<String, dynamic>? params,
  ]) async {
    final domain = await base.domainSaver.getDomain();
    Log.d('ApiClient -> post() -> domain: $domain');
    return base.post(path, body, params);
  }

  Future<dynamic> put(
    dynamic body, [
    Map<String, dynamic>? params,
  ]) async {
    return base.put(path, body, params);
  }

  Future<dynamic> delete(dynamic body, [Map<String, dynamic>? params]) async {
    return base.delete(path, body, params);
  }
}
