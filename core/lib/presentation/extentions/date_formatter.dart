part of 'extention.dart';

// Format DateTime to String
extension DateTimeFormatter on DateTime {
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);

  /// dd-MM-yyyy
  String get ddMMyyyyDash => DateFormat('dd-MM-yyyy').format(this);

  /// dd/MM/yyyy
  String get ddMMyyyySlash => DateFormat('dd/MM/yyyy').format(this);

  String get ddMMyyyyVN => DateFormat('dd-MM-yyyy', 'vi_VN').format(this);
  String get dd => DateFormat('dd').format(this);
  String get MM => DateFormat('MM').format(this);
  String get EEEEddMMyyyyVN =>
      DateFormat('EEEE, dd/MM/yyyy', 'vi_VN').format(this);
  String get hhMM => DateFormat('hh:mm').format(this);
}

// tryParse String to DateTime
extension StringDateFormatter on String {
  /// to DateTime with format yyyy-MM-dd
  DateTime? get toYYYYMMdd {
    try {
      return DateFormat('yyyy-MM-dd').parse(this);
    } catch (_) {
      return null;
    }
  }

  /// to DateTime with format dd-MM-yyyy
  DateTime? get toDDMMYYYY {
    try {
      return DateFormat('dd-MM-yyyy').parse(this);
    } catch (_) {
      return null;
    }
  }
  // to DateTime with format dd/MM/yyyy

  DateTime? get toDDMMYYYYSlash {
    try {
      return DateFormat('dd-MM-yyyy').parse(this);
    } catch (_) {
      return null;
    }
  }

  String get ddMMYYYSlash => DateFormat('dd/MM/yyyy').format(toDDMMYYYYSlash!);
}
