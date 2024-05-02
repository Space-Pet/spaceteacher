import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get yyyyMMdd => DateFormat('yyyy-MM-dd').format(this);
}