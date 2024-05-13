import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class DomainSaver {
  static const domainKey = 'domain';

  String cachedDomain = '';
  Future<bool> saveDomain({required String domain}) async {
    // Save domain to local storage
    try {
      final isValid = await isDomainValid(domain);
      if (isValid) {
        final box = await Hive.openBox(domainKey);
        await box.put(domainKey, domain);
        await box.close();
        cachedDomain = domain;
        return true;
      }
    } catch (_) {}
    return false;
  }

  // private method
  String? _extractDomain(String url) {
    try {
      final parsedUrl = Uri.tryParse(url);
      return parsedUrl?.host;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isDomainValid(String rawString) async {
    // Check if domain is valid via API call
    // https://domain/api/v1/check-domain
    final domain = _extractDomain(rawString);

    if (domain == null) {
      // invalid domain
      return false;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        'https://$domain/api/v1/check-domain',
        data: {'domain': domain},
      );
      if (response.statusCode == 200 && response.data['code'] == 200) {
        return true;
      }
    } catch (_) {
      rethrow;
    }
    return false;
  }

  Future<bool> clearDomain() async {
    // Clear domain from local storage
    try {
      final box = await Hive.openBox(domainKey);
      await box.delete(domainKey);
      await box.close();
    } catch (_) {}

    cachedDomain = '';
    return true;
  }

  Future<String> getDomain() async {
    // Get domain from local storage
    try {
      final box = await Hive.openBox(domainKey);
      final domain = box.get(domainKey) as String?;
      if (domain != null) {
        cachedDomain = domain;
      }
      await box.close();
    } catch (_) {}
    return cachedDomain;
  }
}
