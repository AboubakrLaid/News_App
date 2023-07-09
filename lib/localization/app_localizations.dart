import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/util/export.dart';

extension AppLocalizationsGetter on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this);
  // context.localization. instead of AppLocalization.of(context)
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    String jsonStrings =
        await rootBundle.loadString("lang/${locale.languageCode}.json");

    Map<String, dynamic> map = json.decode(jsonStrings);

    _localizedStrings =
        map.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  // this method will be called from every widget that has a text need to
  // be translated
  String translate(String key) => _localizedStrings![key]!;
}

// this class is defined to let flutter step in
// and call the previous load methode
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => appLanguage.supportedLocales
      .map((locale) => locale.languageCode).toList()
      .contains(locale.languageCode);

  // this methode is called by the flutter sdk
  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);

    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}