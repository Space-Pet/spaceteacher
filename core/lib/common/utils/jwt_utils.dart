import 'package:jwt_decode/jwt_decode.dart';

class JwtUtils {
  static bool isAboutToExpire(
    String token, {
    Duration limit = const Duration(seconds: 5),
  }) {
    try {
      final expiryDate = Jwt.getExpiryDate(token);
      final currentTime = DateTime.now().toUtc();
      return expiryDate?.subtract(limit).isBefore(currentTime) == true;
    } catch (e) {
      return true;
    }
  }

  static Map<String, dynamic> decode(String token) {
    try {
      return Jwt.parseJwt(token);
    } catch (e) {
      return {};
    }
  }
}
