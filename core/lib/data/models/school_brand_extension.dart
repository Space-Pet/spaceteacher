import '../hive_models/hive_models.dart';

extension SchoolBrandExtension on SchoolBrand {
  String get value {
    switch (this) {
      case SchoolBrand.uka:
        return 'uka';
      case SchoolBrand.sga:
        return 'sga';
      case SchoolBrand.sna:
        return 'sna';
      case SchoolBrand.iec:
        return 'iec';
      case SchoolBrand.ischool:
        return 'ischool';
    }
  }

  String get assetPath {
    switch (this) {
      case SchoolBrand.uka:
        return 'assets/icons/brandBackground/uka.svg';
      case SchoolBrand.sga:
        return 'assets/icons/brandBackground/sga.svg';
      case SchoolBrand.sna:
        return 'assets/icons/brandBackground/sna.svg';
      case SchoolBrand.iec:
        return 'assets/icons/brandBackground/iec.svg';
      case SchoolBrand.ischool:
        return 'assets/icons/brandBackground/ischool.svg';
    }
  }
}
