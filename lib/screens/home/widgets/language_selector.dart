import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:news/main.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: Localizations.localeOf(context),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          MyApp.setLocale(context, newLocale);
        }
      },
      items: [
        DropdownMenuItem(
          value: Locale('en'),
          child: Text(AppLocalizations.of(context)!.english),
        ),
        DropdownMenuItem(
          value: Locale('hr'),
          child: Text(AppLocalizations.of(context)!.croatian),
        ),
      ],
    );
  }
}
