import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourscan/Screens/Scaning.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/features/Splash/views/splash_view.dart';
import 'package:tourscan/features/chatBot/presentation/chat_bot_screen.dart';
import 'package:tourscan/generated/l10n.dart';

import 'Screens/About.dart';
import 'Screens/ChatScreen.dart';
import 'Screens/Forgetpassword.dart';
import 'Screens/Home.dart';
import 'Screens/Login.dart';
import 'Screens/NewPassord.dart';
import 'Screens/Register.dart';
import 'Screens/Setting.dart';
import 'Screens/StartedScreen.dart';
import 'Screens/chat list screen.dart';
import 'Screens/pyramids.dart';
import 'firebase_options.dart';

SharedPreferences? sharedpref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedpref = await SharedPreferences.getInstance();

  // Get saved language code or default to 'ar'
  String? langCode = sharedpref?.getString('language') ?? 'ar';

  // Update the LanguageUtil notifier
  LanguageUtil.updateLocale(langCode);

  runApp(MyApp(locale: Locale(langCode)));
}

class MyApp extends StatelessWidget {
  final Locale locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF582218),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/Login': (context) => const Login(),
        '/SignUpScreen': (context) => const SignUpScreen(),
        '/chatscreen': (context) =>
            const ChatScreen(currentUser: 'BEBO', chatPartner: 'ALic'),
        '/Started': (context) => const Startedscreen(),
        '/ChatBot': (context) => const ChatBotScreen(),
        '/ChatListScreen': (context) => ChatListScreen(),
        '/ForgetPasswordScreen': (context) => const ForgetPasswordScreen(),
        '/ChangeNewPasswordScreen': (context) =>
            const NewPasswordScreen(email: 'Mohamed@gmail.com'),
        '/SettingsPage': (context) => const SettingsPage(),
        '/AboutPage': (context) => const AboutPage(),
        '/HomePage': (context) => const HomePage(),
        '/Pyramids': (context) => const Pyramids(),
        '/ScanningPage': (context) => const ScanningPage(),
        '/SplashView': (context) => const SplashView(),
      },
      initialRoute: '/SplashView',
    );
  }
}
