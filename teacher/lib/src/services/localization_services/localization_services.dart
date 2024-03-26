import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationServices {
  static final LocalizationServices _instance =
      LocalizationServices._internal();

  factory LocalizationServices() {
    return _instance;
  }

  LocalizationServices._internal();

  static LocalizationServices of(BuildContext context) {
    return Localizations.of<LocalizationServices>(
        context, LocalizationServices)!;
  }

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('vn', 'VN'),
  ];

  static const List<String> supportedLanguages = [
    'English',
    'Vietnamese',
  ];

  late Map<String, String> _localizedString;

  final Locale _locale = supportedLocales.first;

  Locale get locale => _locale;

  Future<void> load() async {
    for (Locale locale in supportedLocales) {
      String jsonString = await rootBundle.loadString(
          'assets/i18n/${locale.languageCode}-${locale.countryCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedString = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    }
  }

  String? translate(String key) {
    return _localizedString[key];
  }

  static Locale? localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale?.languageCode ||
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }

    return supportedLocales.first;
  }

  static const LocalizationsDelegate<LocalizationServices> _delegate =
      _LocalizationServicesDelegate();
  static const localizationDelegate = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _delegate,
  ];
}

class _LocalizationServicesDelegate
    extends LocalizationsDelegate<LocalizationServices> {
  const _LocalizationServicesDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vn'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationServices> load(Locale locale) async {
    LocalizationServices localizations = LocalizationServices();
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationServices> old) => false;
}
