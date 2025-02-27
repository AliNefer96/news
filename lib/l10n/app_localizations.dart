import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<void> load() async {
    String jsonString = await rootBundle.loadString('lib/l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String get newsTitle => _localizedStrings['newsTitle'] ?? 'NEWS';
  String get newsCategory => _localizedStrings['newsCategory'] ?? 'Category';
  String get registerTitle => _localizedStrings['registerTitle'] ?? 'Register';
  String get firstName => _localizedStrings['firstName'] ?? 'First Name';
  String get lastName => _localizedStrings['lastName'] ?? 'Last Name';
  String get phoneNumber => _localizedStrings['phoneNumber'] ?? 'Phone Number';
  String get email => _localizedStrings['email'] ?? 'Email';
  String get password => _localizedStrings['password'] ?? 'Password';
  String get birthdayLabel => _localizedStrings['birthdayLabel'] ?? 'Birth Date (YYYY-MM-DD)';
  String get birthdayCard => _localizedStrings['birthdayCard'] ?? 'Send Birthday Card Automatically';
  String get loginTitle => _localizedStrings['loginTitle'] ?? 'Login';
  String get english => _localizedStrings['english'] ?? 'English';
  String get croatian => _localizedStrings['croatian'] ?? 'Croatian';
  String get newsDetails => _localizedStrings['newsDetails'] ?? 'News Details';
  String get alreadyHaveAcc => _localizedStrings['alreadyHaveAcc'] ?? 'Already have an account? Login';
  String get dontHaveAcc => _localizedStrings['dontHaveAcc'] ?? 'Not registered? Register here';
  String get welcome => _localizedStrings['welcome'] ?? 'Welcome';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
