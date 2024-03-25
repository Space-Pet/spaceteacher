import 'package:intl/intl.dart';

extension DateTimeFormatX on DateTime {
  String toUtcString() {
    DateTime utcTime = toUtc();

    return '${DateFormat('yyyy-MM-ddTHH:mm:ss').format(utcTime)}Z';
  }
}
