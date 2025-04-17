// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome To Tour Scan`
  String get title {
    return Intl.message(
      'Welcome To Tour Scan',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Find your Next Adventure`
  String get subtitle {
    return Intl.message(
      'Find your Next Adventure',
      name: 'subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Artifacts`
  String get artifacts {
    return Intl.message('Artifacts', name: 'artifacts', desc: '', args: []);
  }

  /// `Statues`
  String get statues {
    return Intl.message('Statues', name: 'statues', desc: '', args: []);
  }

  /// `Egyptian Museum`
  String get egyptianMuseum {
    return Intl.message(
      'Egyptian Museum',
      name: 'egyptianMuseum',
      desc: '',
      args: [],
    );
  }

  /// `Cairo, Giza`
  String get giza {
    return Intl.message('Cairo, Giza', name: 'giza', desc: '', args: []);
  }

  /// `Search...`
  String get Search {
    return Intl.message('Search...', name: 'Search', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `User Name`
  String get username {
    return Intl.message('User Name', name: 'username', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Ask`
  String get ask {
    return Intl.message('Ask', name: 'ask', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Capture Image`
  String get captureImage {
    return Intl.message(
      'Capture Image',
      name: 'captureImage',
      desc: '',
      args: [],
    );
  }

  /// `Pick From Gallery`
  String get Gallery {
    return Intl.message(
      'Pick From Gallery',
      name: 'Gallery',
      desc: '',
      args: [],
    );
  }

  /// `Statue Recognition`
  String get statueRecognition {
    return Intl.message(
      'Statue Recognition',
      name: 'statueRecognition',
      desc: '',
      args: [],
    );
  }

  /// `Detected`
  String get Detected {
    return Intl.message('Detected', name: 'Detected', desc: '', args: []);
  }

  /// `statueNotRecognized`
  String get statueNotRecognized {
    return Intl.message(
      'statueNotRecognized',
      name: 'statueNotRecognized',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get languageCode {
    return Intl.message('en', name: 'languageCode', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
