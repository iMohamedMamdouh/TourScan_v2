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

  /// `Full Name`
  String get FullName {
    return Intl.message('Full Name', name: 'FullName', desc: '', args: []);
  }

  /// `Email`
  String get Email {
    return Intl.message('Email', name: 'Email', desc: '', args: []);
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message('Address', name: 'Address', desc: '', args: []);
  }

  /// `Age`
  String get Age {
    return Intl.message('Age', name: 'Age', desc: '', args: []);
  }

  /// `Gender`
  String get Gender {
    return Intl.message('Gender', name: 'Gender', desc: '', args: []);
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message('Sign Up', name: 'SignUp', desc: '', args: []);
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message('Sign In', name: 'SignIn', desc: '', args: []);
  }

  /// `ChangePassword`
  String get ChangePassword {
    return Intl.message(
      'ChangePassword',
      name: 'ChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get UpdateData {
    return Intl.message('Update Data', name: 'UpdateData', desc: '', args: []);
  }

  /// `NewPassword`
  String get NewPassword {
    return Intl.message('NewPassword', name: 'NewPassword', desc: '', args: []);
  }

  /// `CurrentPassword`
  String get CurrentPassword {
    return Intl.message(
      'CurrentPassword',
      name: 'CurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `HideChangePassword`
  String get hideChangePassword {
    return Intl.message(
      'HideChangePassword',
      name: 'hideChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `currentPasswordIncorrect`
  String get currentPasswordIncorrect {
    return Intl.message(
      'currentPasswordIncorrect',
      name: 'currentPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `passwordsDoNotMatch`
  String get passwordsDoNotMatch {
    return Intl.message(
      'passwordsDoNotMatch',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `updatePasswordFailed`
  String get updatePasswordFailed {
    return Intl.message(
      'updatePasswordFailed',
      name: 'updatePasswordFailed',
      desc: '',
      args: [],
    );
  }

  /// `dataUpdatedSuccessfully`
  String get dataUpdatedSuccessfully {
    return Intl.message(
      'dataUpdatedSuccessfully',
      name: 'dataUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `ChatBot`
  String get ChatBot {
    return Intl.message('ChatBot', name: 'ChatBot', desc: '', args: []);
  }

  /// `assets/send.svg`
  String get sendIcon {
    return Intl.message(
      'assets/send.svg',
      name: 'sendIcon',
      desc: '',
      args: [],
    );
  }

  /// `Tour Scan is an innovative mobile application designed to enhance the experience of tourists by providing instant information about statues, landmarks, and other attractions. By using a smartphone camera, users can scan a monument or tourist site, and the app will recognize it, retrieving detailed historical and cultural information.`
  String get aboutTourScan {
    return Intl.message(
      'Tour Scan is an innovative mobile application designed to enhance the experience of tourists by providing instant information about statues, landmarks, and other attractions. By using a smartphone camera, users can scan a monument or tourist site, and the app will recognize it, retrieving detailed historical and cultural information.',
      name: 'aboutTourScan',
      desc: '',
      args: [],
    );
  }

  /// `Enter your message`
  String get Enteryourmessage {
    return Intl.message(
      'Enter your message',
      name: 'Enteryourmessage',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get LoginToYourAccount {
    return Intl.message(
      'Login to your account',
      name: 'LoginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Please enter your details.`
  String get WelcomeBackPleaseEnterYourDetails {
    return Intl.message(
      'Welcome back! Please enter your details.',
      name: 'WelcomeBackPleaseEnterYourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get EmailAddress {
    return Intl.message(
      'Email Address',
      name: 'EmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get EnterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'EnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get EnterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'EnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get ForgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'ForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get SignInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'SignInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get DontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'DontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get fieldIsRequired {
    return Intl.message(
      'Field is required',
      name: 'fieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get CreateAnAccount {
    return Intl.message(
      'Create an account',
      name: 'CreateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Join us and explore new possibilities!`
  String get JoinUsAndExplore {
    return Intl.message(
      'Join us and explore new possibilities!',
      name: 'JoinUsAndExplore',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message('Male', name: 'Male', desc: '', args: []);
  }

  /// `Female`
  String get Female {
    return Intl.message('Female', name: 'Female', desc: '', args: []);
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Creating Account...`
  String get CreateAccountDot {
    return Intl.message(
      'Creating Account...',
      name: 'CreateAccountDot',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get AlreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'AlreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get ForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered email below`
  String get EnterYourRegisteredEmailBelow {
    return Intl.message(
      'Enter your registered email below',
      name: 'EnterYourRegisteredEmailBelow',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message('Submit', name: 'Submit', desc: '', args: []);
  }

  /// `Remember the password? `
  String get RememberThePassword {
    return Intl.message(
      'Remember the password? ',
      name: 'RememberThePassword',
      desc: '',
      args: [],
    );
  }

  /// `No data available.`
  String get NoDataAvailable {
    return Intl.message(
      'No data available.',
      name: 'NoDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Egyptian Museum`
  String get EgyptianMuseum {
    return Intl.message(
      'Egyptian Museum',
      name: 'EgyptianMuseum',
      desc: '',
      args: [],
    );
  }

  /// `The Egyptian Museum in Cairo (EMC) is the oldest archaeological museum in the Middle East, housing over 170,000 artefacts. It has the largest collection of Pharaonic antiquities in the world.\n\nThe Museum’s exhibits span the Pre-Dynastic Period till the Graeco-Roman Era (c. 5500 BC - AD 364).`
  String get MuseumDescription {
    return Intl.message(
      'The Egyptian Museum in Cairo (EMC) is the oldest archaeological museum in the Middle East, housing over 170,000 artefacts. It has the largest collection of Pharaonic antiquities in the world.\n\nThe Museum’s exhibits span the Pre-Dynastic Period till the Graeco-Roman Era (c. 5500 BC - AD 364).',
      name: 'MuseumDescription',
      desc: '',
      args: [],
    );
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
