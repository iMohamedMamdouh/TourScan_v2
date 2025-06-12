import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/About.dart';
import 'package:tourscan/Screens/Home.dart';
import 'package:tourscan/Screens/Setting.dart';
import 'package:tourscan/Screens/chat%20list%20screen.dart';
import 'package:tourscan/Widgets/language_switch_tile.dart';
import 'package:tourscan/generated/l10n.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  // Logout method: clears SharedPreferences and signs out via Firebase.
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  // Fetch user data from Firestore.
  Future<DocumentSnapshot?> _getUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kPrimaryColor,
      child: Column(
        children: [
          // User data section
          Container(
            padding: const EdgeInsets.only(top: 64, bottom: 20),
            child: FutureBuilder<DocumentSnapshot?>(
              future: _getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: kSecondaryColor,
                  );
                }
                var userData = snapshot.data?.data() as Map<String, dynamic>?;

                return Column(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: kSecondaryColor,
                      child: Icon(Icons.person, size: 80, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      userData?['fullName'] ?? S.of(context).username,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userData?['email'] ?? "user@example.com",
                      style: const TextStyle(
                        color: Color(0xffBAB8B5),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      thickness: 1,
                      color: Colors.black54,
                      indent: 30,
                      endIndent: 30,
                    ),
                  ],
                );
              },
            ),
          ),
          // Navigation items
          _buildDrawerItem(
            icon: const Icon(Icons.home, color: Color(0xFF582218)),
            title: S.of(context).home,
            context: context,
            onTap: () {
              Navigator.pop(context); // Just closes the drawer
            },
          ),

          _buildDrawerItem(
            icon: const Icon(Icons.settings, color: Color(0xFF582218)),
            title: S.of(context).settings,
            context: context,
            page: const SettingsPage(),
          ),
          _buildDrawerItem(
            icon: Icon(FontAwesomeIcons.rocketchat, color: Color(0xFF582218)),
            title: S.of(context).ask,
            context: context,
            page: const ChatListScreen(),
          ),
          _buildDrawerItem(
            icon: const Icon(Icons.info, color: Color(0xFF582218)),
            title: S.of(context).about,
            context: context,
            page: const AboutPage(),
          ),
          // Language switch as a ListTile to match other items
          const LanguageSwitchTile(),
          const Spacer(),
          // Logout button at the end of the drawer
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF582218)),
              title: Text(S.of(context).logout),
              onTap: () => _logout(context),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a drawer item.
  Widget _buildDrawerItem({
    required Widget icon,
    required String title,
    required BuildContext context,
    Widget? page,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: onTap ??
          () {
            if (page != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          },
    );
  }
}

// A stateful widget that provides the language switch as a ListTile.
// This version displays a single text label and positions the switch at the end,
// matching the style of other drawer items.
