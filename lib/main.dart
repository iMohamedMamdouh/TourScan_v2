import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourscan/Screens/Scaning.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/features/Splash/views/splash_view.dart';
import 'package:tourscan/features/chatBot/presentation/chat_bot_screen.dart';
import 'package:tourscan/generated/l10n.dart';
import 'package:tourscan/utils/animation_utils.dart';

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
import 'Screens/statuesScreen.dart';
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
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder(),
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/Login':
            return CustomPageRoute(
              child: const Login(),
              transitionType: PageTransitionType.slideRight,
            );
          case '/SignUpScreen':
            return CustomPageRoute(
              child: const SignUpScreen(),
              transitionType: PageTransitionType.slideRight,
            );
          case '/chatscreen':
            return CustomPageRoute(
              child:
                  const ChatScreen(currentUser: 'Alice', chatPartner: 'Guide'),
              transitionType: PageTransitionType.slideUp,
            );
          case '/Started':
            return CustomPageRoute(
              child: const Startedscreen(),
              transitionType: PageTransitionType.fade,
            );
          case '/ChatBot':
            return CustomPageRoute(
              child: const ChatBotScreen(),
              transitionType: PageTransitionType.slideUp,
            );
          case '/ChatListScreen':
            return CustomPageRoute(
              child: ChatListScreen(),
              transitionType: PageTransitionType.slideRight,
            );
          case '/ForgetPasswordScreen':
            return CustomPageRoute(
              child: const ForgetPasswordScreen(),
              transitionType: PageTransitionType.slideRight,
            );
          case '/ChangeNewPasswordScreen':
            return CustomPageRoute(
              child: const NewPasswordScreen(email: 'Mohamed@gmail.com'),
              transitionType: PageTransitionType.slideRight,
            );
          case '/SettingsPage':
            return CustomPageRoute(
              child: const SettingsPage(),
              transitionType: PageTransitionType.slideRight,
            );
          case '/AboutPage':
            return CustomPageRoute(
              child: const AboutPage(),
              transitionType: PageTransitionType.slideRight,
            );
          case '/HomePage':
            return CustomPageRoute(
              child: const HomePage(),
              transitionType: PageTransitionType.fade,
            );
          case '/StatuesScreen':
            return CustomPageRoute(
              child: const StatuesScreen(),
              transitionType: PageTransitionType.slideUp,
            );
          case '/ScanningPage':
            return CustomPageRoute(
              child: const ScanningPage(),
              transitionType: PageTransitionType.slideUp,
            );
          case '/SplashView':
            return CustomPageRoute(
              child: const SplashView(),
              transitionType: PageTransitionType.fade,
            );
          default:
            return CustomPageRoute(
              child: const SplashView(),
              transitionType: PageTransitionType.fade,
            );
        }
      },
      initialRoute: '/SplashView',
    );
  }
}

class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionsBuilder();

  @override
  Widget buildTransitions<T extends Object?>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    );
  }
}
