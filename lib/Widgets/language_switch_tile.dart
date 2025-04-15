import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/generated/l10n.dart';
import 'package:tourscan/main.dart'; // For MyApp

class LanguageSwitchTile extends StatefulWidget {
  const LanguageSwitchTile({super.key});

  @override
  _LanguageSwitchTileState createState() => _LanguageSwitchTileState();
}

class _LanguageSwitchTileState extends State<LanguageSwitchTile> {
  bool isEnglish = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentLang = Localizations.localeOf(context).languageCode;
      setState(() {
        isEnglish = (currentLang == 'en');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: const Icon(Icons.language, color: kSecondaryColor),
        title: Text(
          S.of(context).language, // You can use localization for "Language"
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Switch(
          value: isEnglish,
          onChanged: (bool value) async {
            setState(() {
              isEnglish = value;
            });
            final newLang = isEnglish ? 'en' : 'ar';
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('language', newLang);
            LanguageUtil.updateLocale(newLang); // Update the locale
            runApp(
                MyApp(locale: Locale(newLang))); // Rebuild with the new locale
          },
          activeTrackColor: kSecondaryColor,
        ),
      ),
    );
  }
}
