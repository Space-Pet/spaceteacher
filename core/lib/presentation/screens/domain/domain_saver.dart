import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class DomainSaver {
  static const domainKey = 'domain';

  String cachedDomain = '';

  Box? box;

  Future<void> tryOpenHive() async {
    try {
      box = await Hive.openBox(domainKey);
    } catch (_) {}
  }

  Future<void> tryCloseHive() async {
    try {
      await box?.close();
    } catch (_) {}
  }

  Future<bool> saveDomain({required String domain}) async {
    // Save domain to local storage
    try {
      final isValid = await isDomainValid(domain);
      if (isValid) {
        await tryOpenHive();
        await box?.put(domainKey, domain);
        await tryCloseHive();
        cachedDomain = domain;
        return true;
      }
    } catch (_) {}
    return false;
  }

  // private method
  String? _extractDomain(String url) {
    final parts = url.split('://');
    if (parts.length > 1) {
      return parts[1].split('/')[0]; // Get domain from first part after "://"
    } else {
      // Handle URLs without "://" (e.g., www.example.com)
      final newParts = parts[0].split('/');
      if (newParts.length > 1) {
        return newParts[0]; // Get domain from first part before "/"
      } else if (newParts.length == 1) {
        return newParts[0]; // Get domain from first part
      } else {
        return null; // Invalid domain
      }
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
      // TODO: Need to check incase user 's input include https
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
      await tryOpenHive();
      await box?.delete(domainKey);
      await tryCloseHive();
    } catch (_) {}

    cachedDomain = '';
    return true;
  }

  Future<String> getDomain() async {
    // Get domain from local storage
    if(cachedDomain.isNotEmpty) {
      return cachedDomain;
    }
    
    try {
      await tryOpenHive();
      final domain = box?.get(domainKey) as String?;
      if (domain != null) {
        cachedDomain = domain;
      }
      await tryCloseHive();
    } catch (_) {}
    return cachedDomain;
  }
}
