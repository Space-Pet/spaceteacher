import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tag_format;

import '../constants/app_locale.dart';

class DateUtils {
  static const List<String> normalFullFormat = [
    HH,
    ':',
    nn,
    ' - ',
    dd,
    '/',
    mm,
    '/',
    yyyy
  ];

  static const List<String> transactionFormat = [
    HH,
    ':',
    nn,
    ' - ',
    dd,
    ' thg ',
    mm,
    ', ',
    yyyy
  ];

  static const List<String> timeFormat = [
    HH,
    ':',
    nn,
  ];

  static const List<String> dateWithWeekdayFormat = [
    D,
    ', ',
    dd,
    '/',
    mm,
    '/',
    yyyy
  ];

  static const List<String> normalDateFormat = [dd, '/', mm, '/', yyyy];

  static const List<String> dateOfWeekFormat = [
    D,
    ', ',
    dd,
    ' thg ',
    mm,
    ', ',
    yyyy
  ];

  static const List<String> normalUTCFormat = [yyyy, '/', mm, '/', dd];

  static const List<String> bookingDateFormat = [dd, '/', mm, '/', yyyy];

  static const List<String> dateServerFormat = [yyyy, '-', mm, '-', dd];

  static const List<String> bookingDateTimeFormat = [
    HH,
    ':',
    nn,
    ', ',
    dd,
    '/',
    mm,
    '/',
    yyyy,
  ];

  static const List<String> dateTimeFull = [
    dd,
    '/',
    mm,
    '/',
    yyyy,
    ', ',
    HH,
    ':',
    nn,
  ];
}

extension DateUtilsExtention on DateTime {
  String serverToTransaction() {
    return formatDate(
      toLocal(),
      DateUtils.transactionFormat,
    );
  }

  bool get isToday {
    final now = DateTime.now().toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final date = toLocal();
    return today == DateTime(date.year, date.month, date.day);
  }

  String serverToNormalDateFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.normalDateFormat,
      locale: Localizations.localeOf(context).languageCode ==
              AppLocale.en.languageCode
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  String toNormalDateFormat() {
    return formatDate(
      this,
      DateUtils.normalDateFormat,
    );
  }

  String serverToDateTimeFull() {
    return formatDate(
      toLocal(),
      DateUtils.dateTimeFull,
    );
  }

  String serverToNormalFullFormat() {
    return formatDate(
      toLocal(),
      DateUtils.normalFullFormat,
    );
  }

  String serverToNormalUTCFullFormat() {
    return formatDate(
      toUtc(),
      DateUtils.normalFullFormat,
    );
  }

  String serverToDateOfWeek() {
    return formatDate(
      toLocal(),
      DateUtils.dateOfWeekFormat,
    );
  }

  String toServerNormalUTCFormat() {
    return formatDate(
      toUtc(),
      DateUtils.normalUTCFormat,
    );
  }

  String toDateServerFormat() {
    return formatDate(
      toUtc(),
      DateUtils.dateServerFormat,
    );
  }

  String toDateServerNormalFormat() {
    return formatDate(
      this,
      DateUtils.dateServerFormat,
    );
  }

  String toBookingDateTimeFormat() {
    return formatDate(
      toLocal(),
      DateUtils.bookingDateTimeFormat,
    );
  }

  String? timeago() {
    return tag_format.format(
      this,
      locale: 'vn',
      allowFromNow: true,
    );
  }

  String toTimeFormat() {
    return formatDate(
      toLocal(),
      DateUtils.timeFormat,
    );
  }

  String toDateWithWeekdayFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.dateWithWeekdayFormat,
      locale: Localizations.localeOf(context).languageCode ==
              AppLocale.en.languageCode
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

    String toDateWithWeekdayFormatVN() {
    return formatDate(
      toLocal(),
      DateUtils.dateWithWeekdayFormat,
      locale: const VietnameseDateLocale(),
    ).substring(0,2);
  }

  String toOnlyMonthFullFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      [M],
      locale: Localizations.localeOf(context).languageCode ==
              AppLocale.en.languageCode
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  String toOnlYearFullFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      [yyyy],
      locale: Localizations.localeOf(context).languageCode ==
              AppLocale.en.languageCode
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }
}
