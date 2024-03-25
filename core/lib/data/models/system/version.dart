import 'package:intl/intl.dart';

class Version {
  final String? version;
  int buildNumber;

  String? _buildDate;
  set buildDate(String value) => _buildDate = value;
  String get buildDate {
    if (_buildDate == null || _buildDate!.isEmpty) {
      final formatter = DateFormat.yMd();
      return formatter.format(DateTime.now());
    }
    return _buildDate!;
  }

  String get defaultVersion => '1.0.0';

  List<String> get _splitVersion =>
      version?.split('.') ?? defaultVersion.split('.');

  int get versionNumber {
    return int.tryParse(_splitVersion.first) ?? 1;
  }

  int get major {
    return int.tryParse(_splitVersion[1]) ?? 0;
  }

  int get minor {
    return int.tryParse(_splitVersion[2]) ?? 0;
  }

  bool get isValidVersion =>
      version!.isNotEmpty && version?.split('.').length == 3;

  bool get isNotValidVersion => !isValidVersion;

  @override
  String toString() {
    if (isNotValidVersion) {
      return 'Input version is not valid! Using default version 1.0.0';
    }
    return '$version ($buildNumber) - $buildDate';
  }

  Version(this.version, {this.buildNumber = 1});
}
