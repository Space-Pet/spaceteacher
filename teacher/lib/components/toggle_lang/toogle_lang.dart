import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  }

  Future<void> _toggleLanguage() async {
    String newLanguage = _currentLanguage == 'en' ? 'vi' : 'en';
    setState(() {
      _currentLanguage = newLanguage;
      context.setLocale(
          Locale(_currentLanguage, LangUtils.getCountryCode(_currentLanguage)));
    });

    // TODO: Implement language change logic
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CountryFlag.fromCountryCode(
              LangUtils.getLangCodeCountryFlag(context.locale.languageCode),
              borderRadius: 30,
              width: 30,
              height: 30,
            ),
            const Text("current_language").tr(),
            Text(': ${LangUtils.getLangName(context.locale.languageCode)}'),
          ],
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _toggleLanguage,
          child: const Text('toggle_language').tr(args: ['toggle_language']),
        ),
      ],
    );
  }
}
