import 'env_config.dart';

class EnvironmentConfigOverride extends EnvironmentConfig {
  static String get env => EnvironmentConfig.env;

  static String get baseUrl => _baseURL;

  static String _baseURL = '';
  static set baseURL(String value) {
    _baseURL = value;
  }
}