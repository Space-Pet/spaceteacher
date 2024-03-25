import 'models/models.dart';

abstract class AbstractAuthLocalStorage {
  Future saveLoginInfo({required String email, required String password});
  Future<LocalLoginInfo?> getLoginInfo();
  Future clearLoginInfo();
}
