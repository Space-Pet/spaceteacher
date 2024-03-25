import '../envs.dart';

class Config {
  static final Config instance = Config._();

  Config._();

  AppConfig get appConfig => _appConfig;
  late AppConfig _appConfig;

  void setup(Map<String, dynamic> env) {
    _appConfig = AppConfig.from(env);
  }

  AppType get app {
    return _appConfig.app;
  }
}

class AppConfig {
  String envName;
  bool developmentMode;
  String appName;
  String baseApiLayer;
  String baseGraphQLUrl;
  String graphqlSocketUrl;
  AppType app;
  String graphqlApiKey;

  AppConfig(
    this.envName,
    this.developmentMode,
    this.appName,
    this.baseApiLayer,
    this.baseGraphQLUrl,
    this.graphqlSocketUrl,
    this.app,
    this.graphqlApiKey,
  );

  AppConfig.from(Map<String, dynamic> env)
      : envName = env[Env.environment],
        developmentMode = env[Env.developmentMode],
        appName = env[Env.appName],
        baseApiLayer = env[Env.baseApiLayer],
        baseGraphQLUrl = env[Env.baseGraphQLUrl],
        app = env[Env.app],
        graphqlApiKey = env[Env.graphqlApiKey],
        graphqlSocketUrl = env[Env.graphqlSocketUtl];

  bool get isiportalApp {
    return app == AppType.iportal2;
  }

  bool get isteacherApp {
    return app == AppType.teacher;
  }

  bool get isDevBuild => developmentMode == true;
}
