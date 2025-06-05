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
  String currentLanguage = 'ar';
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentLang = Localizations.localeOf(context).languageCode;
      setState(() {
        currentLanguage = currentLang;
      });
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    LanguageUtil.updateLocale(languageCode);
    runApp(MyApp(locale: Locale(languageCode)));
  }

  String _getLanguageDisplayName() {
    return currentLanguage == 'ar' ? 'العربية' : 'English';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language, color: kSecondaryColor),
          title: Text(
            S.of(context).language,
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(
            _getLanguageDisplayName(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          trailing: AnimatedRotation(
            turns: isExpanded
                ? (currentLanguage == 'ar' ? -0.25 : 0.25)
                : (currentLanguage == 'ar' ? 0.5 : 0),
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: kSecondaryColor,
              size: 16,
            ),
          ),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? 100 : 0,
          child: ClipRect(
            child: isExpanded
                ? SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(left: 32, right: 16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Radio<String>(
                              value: 'ar',
                              groupValue: currentLanguage,
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    currentLanguage = value;
                                    isExpanded = false;
                                  });
                                  _changeLanguage(value);
                                }
                              },
                              activeColor: kSecondaryColor,
                            ),
                            title: const Text(
                              'العربية',
                              style: TextStyle(fontSize: 15),
                            ),
                            onTap: () {
                              setState(() {
                                currentLanguage = 'ar';
                                isExpanded = false;
                              });
                              _changeLanguage('ar');
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          ListTile(
                            leading: Radio<String>(
                              value: 'en',
                              groupValue: currentLanguage,
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    currentLanguage = value;
                                    isExpanded = false;
                                  });
                                  _changeLanguage(value);
                                }
                              },
                              activeColor: kSecondaryColor,
                            ),
                            title: const Text(
                              'English',
                              style: TextStyle(fontSize: 15),
                            ),
                            onTap: () {
                              setState(() {
                                currentLanguage = 'en';
                                isExpanded = false;
                              });
                              _changeLanguage('en');
                            },
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ),
        ),
      ],
    );
  }
}
