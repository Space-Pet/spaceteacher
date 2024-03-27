import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:teacher/src/services/localization_services/localization_services.dart';
import 'package:teacher/src/settings/settings.dart';
import 'package:country_flags/country_flags.dart';
import 'package:teacher/src/utils/lang_utils.dart';

class ToggleLang extends StatefulWidget {
  const ToggleLang({super.key});

  @override
  _ToggleLangState createState() => _ToggleLangState();
}

class _ToggleLangState extends State<ToggleLang> {
  final Settings settings = Injection.get<Settings>();
  String _currentLanguage = '';

  @override
  void initState() {
    super.initState();
    _getInitialLanguage();
    print(_getInitialLanguage());
  }

  Future<void> _getInitialLanguage() async {
    String? language = await settings.getLanguage();
    setState(() {
      _currentLanguage = language; // Default language is 'en' if not set

      print(_currentLanguage);
    });
  }

  Future<void> _toggleLanguage() async {
    String newLanguage = _currentLanguage == 'en' ? 'vi' : 'en';
    await settings.saveLanguage(newLanguage);
    setState(() {
      _currentLanguage = newLanguage;
    });
    // TODO: Implement language change logic
  }

  @override
  Widget build(BuildContext context) {
    final localizeServices = LocalizationServices.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CountryFlag.fromCountryCode(
              LangUtils.getLangCodeCountryFlag(_currentLanguage),
              borderRadius: 30,
              width: 30,
              height: 30,
            ),
            Text(
                '${localizeServices.translate("current_language")}: ${LangUtils.getLangName(_currentLanguage)}'),
          ],
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _toggleLanguage,
          child: Text(localizeServices.translate('toggle_language') ??
              "Toggle Language"),
        ),
      ],
    );
  }
}
