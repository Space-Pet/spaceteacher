import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnviromentFlavor { dev, release }

class Enviroment {
  static String endPointDev = dotenv.env['ENDPOINT_DEV'] ?? "";
  static String endPointRelease = dotenv.env['ENDPOINT_RELEASE'] ?? "";
  static EnviromentFlavor flavor = EnviromentFlavor.dev;

  static void initFlavor(EnviromentFlavor flavor) {
    Enviroment.flavor = flavor;
  }
}
