enum EnviromentFlavor { dev, release }

class Enviroment {
  static EnviromentFlavor flavor = EnviromentFlavor.dev;
  static String get apiUrl {
    switch (flavor) {
      case EnviromentFlavor.dev:
        return 'https://apitest-iportal.nhg.vn/api/v1/';

      case EnviromentFlavor.release:
        return 'http://api-iportal.local/api/v1/';

      default:
        return 'https://apitest-iportal.nhg.vn/api/v1/';
    }
  }

  static void initFlavor(EnviromentFlavor flavor) {
    Enviroment.flavor = flavor;
  }
}
