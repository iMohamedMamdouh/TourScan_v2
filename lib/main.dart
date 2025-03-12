import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/About.dart';
import 'Screens/ChatScreen.dart';
import 'Screens/Forgetpassword.dart';
import 'Screens/Home.dart';
import 'Screens/Login.dart';
import 'Screens/NewPassord.dart';
import 'Screens/Register.dart';
import 'Screens/Scaning.dart';
import 'Screens/Setting.dart';
import 'Screens/StartedScreen.dart';
import 'Screens/chat list screen.dart';
import 'Screens/pyramids.dart';
import 'firebase_options.dart';

SharedPreferences? sharedpref;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase إذا لم يتم تهيئته مسبقًا
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // الحصول على SharedPreferences
  sharedpref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // جعل الـ AppBar شفاف
          elevation: 0, // إزالة الظل
          titleTextStyle: TextStyle(
            color: Color(0xFF582218), // اللون الجديد
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
        '/Started': (context) => Startedscreen(),
        '/ChatListScreen': (context) => ChatListScreen(),
        '/ForgetPasswordScreen': (context) => const ForgetPasswordScreen(),
        '/ChangeNewPasswordScreen': (context) =>
            const NewPasswordScreen(email: 'Mohamed@gmail.com'),
        '/SettingsPage': (context) => const SettingsPage(),
        '/AboutPage': (context) => AboutPage(),
        '/HomePage': (context) => const HomePage(),
        '/Pyramids': (context) => const Pyramids(),
        '/ScanningPage': (context) => const ScanningPage(),
      },
      initialRoute: '/HomePage',
 