import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';

class CommonFunction {
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String prettyJsonStr(Map<dynamic, dynamic> json) {
    final encoder = JsonEncoder.withIndent('  ', (data) => data.toString());
    return encoder.convert(json);
  }

  static String wrapStyleHtmlContent(String htmlContent) {
    return '''<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <style>* {
        font-family: 'Inter-regular';
        line-height: 1.5;
        margin: 0;
        padding: 0;
      }
      h2 {
        font-size: 24px;
        margin-bottom: 12px;
      }
      h3 {
        font-size: 18px;
        margin-bottom: 12px;
      }
      h4 {
        font-size: 16px;
        margin-bottom: 10px;
      }
      p {
        font-size: 14px;
        margin-bottom: 10px;
      }
      a {
        text-decoration: underline;
      }
      img {
        display: block;
        margin: 0 auto;
        max-width: 100%;
        min-width: 50px;
      }
      .table {
        width: 100% !important;
        table {
          border: 1px double #B3B3B3;
          th, td {
            border: 1px double #D9D9D9;
          }
        }
      }
      figcaption {
        text-align: center;
      }
      div {
        padding-top: 8px;
        padding-right: 8px;
        padding-bottom: 8px;
        padding-left: 8px;
      }</style>
      <body>
        <div>
          $htmlContent
        </div>
      </body>
    </html>''';
  }

  static int calculateAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    var age = currentDate.year - birthDate.year;
    final month1 = currentDate.month;
    final month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = currentDate.day;
      final day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static bool shouldUpdateApp(String currentVersion, String? newVersion) {
    if (newVersion == null || newVersion.isNotEmpty == false) {
      return false;
    }
    return _compareVersionNames(currentVersion, newVersion) < 0;
  }

  @visibleForTesting
  static int compareVersionNames(
    String oldVersionName,
    String newVersionName,
  ) =>
      _compareVersionNames(oldVersionName, newVersionName);

  static bool isTheSameVersion(String a, String b) {
    return _compareVersionNames(a, b) == 0;
  }

  static int _compareVersionNames(
    String oldVersionName,
    String newVersionName,
  ) {
    var res = 0;

    final oldNumbers = oldVersionName.split('.');
    final newNumbers = newVersionName.split('.');

    // To avoid IndexOutOfBounds
    final maxIndex = min(oldNumbers.length, newNumbers.length);

    for (final i in List.generate(maxIndex, (index) => index)) {
      final oldVersionPart = int.tryParse(oldNumbers[i]);
      final newVersionPart = int.tryParse(newNumbers[i]);

      if (newVersionPart == null || oldVersionPart == null) {
        res = -2;
        break;
      }

      if (oldVersionPart < newVersionPart) {
        res = -1;
        break;
      } else if (oldVersionPart > newVersionPart) {
        res = 1;
        break;
      }
    }

    // If versions are the same so far, but they have different length...
    if (res == 0 && oldNumbers.length != newNumbers.length) {
      res = oldNumbers.length > newNumbers.length ? 1 : -1;
    }
    return res;
  }

  static Future<void> navigateToStore(String role) async {
    var storeUrl = '';

    if (role == RoleType.iportal) {
      if (Platform.isIOS) {
        storeUrl = UrlConstants.urlAppStoreiportal;
      } else if (Platform.isAndroid) {
        storeUrl = UrlConstants.urlPlayStoreiportal;
      }
    } else {
      if (Platform.isIOS) {
        storeUrl = UrlConstants.urlAppStoreteacher;
      } else if (Platform.isAndroid) {
        storeUrl = UrlConstants.urlPlayStoreteacher;
      }
    }
    if (await canLaunchUrlString(storeUrl)) {
      await launchUrlString(storeUrl);
    }
  }
}
