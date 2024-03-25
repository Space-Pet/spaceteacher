enum AppType { iportal2, teacher }

class Env {
  static const environment = 'environment';
  static const developmentMode = 'developmentMode';
  static const appName = 'appName';
  static const baseApiLayer = 'baseApiLayer';
  static const baseGraphQLUrl = 'baseGraphQLUrl';
  static const graphqlSocketUtl = 'graphqlSocketUtl';
  static const app = 'app';
  static const graphqlApiKey = 'graphqlApiKey';

  static final Map<String, dynamic> iPortal2Dev = {
    environment: 'WOW Development',
    developmentMode: true,
    appName: 'WOW Dev',
    baseApiLayer: '',
    baseGraphQLUrl: '',
    graphqlSocketUtl: '',
    app: AppType.iportal2,
    graphqlApiKey:
        'fm2ss367h1206socg73lqbd4aa5cb82b8deobissoob6mnm8r36necrpm4ho1rd',
  };

  static final Map<String, dynamic> iPortal2Prod = {
    environment: 'WOW Production',
    developmentMode: false,
    appName: 'WOW Services',
    baseApiLayer: '',
    baseGraphQLUrl: 'https://controller.fixmeapp.vn/v1/graphql',
    graphqlSocketUtl: 'wss://controller.fixmeapp.vn/v1/graphql',
    app: AppType.iportal2,
    graphqlApiKey:
        'fm2ss367h1206socg73lqbd4aa5cb82b8deobissoob6mnm8r36necrpm4ho1rd',
  };

  static final Map<String, dynamic> devteacher = {
    environment: 'WOW Partner Development',
    developmentMode: true,
    appName: 'WOW Partner Dev',
    baseApiLayer: '',
    baseGraphQLUrl: 'https://test-controller.fixmeapp.vn/v1/graphql',
    graphqlSocketUtl: 'wss://test-controller.fixmeapp.vn/v1/graphql',
    app: AppType.teacher,
    graphqlApiKey:
        'fm2ss367h1206socg73lqbd4aa5cb82b8deobissoob6mnm8r36necrpm4ho1rd',
  };

  static final Map<String, dynamic> prodteacher = {
    environment: 'WOW Partner Production',
    developmentMode: false,
    appName: 'WOW Partner',
    baseApiLayer: '',
    baseGraphQLUrl: 'https://controller.fixmeapp.vn/v1/graphql',
    graphqlSocketUtl: 'wss://controller.fixmeapp.vn/v1/graphql',
    app: AppType.teacher,
    graphqlApiKey:
        'fm2ss367h1206socg73lqbd4aa5cb82b8deobissoob6mnm8r36necrpm4ho1rd',
  };
}
