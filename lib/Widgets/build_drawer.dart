import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/About.dart';
import 'package:tourscan/Screens/Setting.dart';
import 'package:tourscan/Screens/chat%20list%20screen.dart';
import 'package:tourscan/Screens/Home.dart'; // HomePage import

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  // Function to handle logout
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved preferences

    // Sign out the user from Firebase
    await FirebaseAuth.instance.signOut();

    // Navigate to HomePage after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(), // Navigate to HomePage
      ), // Redirect to home page
    );
  }

  // Fetch user data from Firestore
  Future<DocumentSnapshot?> _getUserData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 64, bottom: 20),
            child: FutureBuilder<DocumentSnapshot?>(
              future: _getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
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
                      userData?['fullName'] ?? "User Name",
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
          _buildDrawerItem(
            icon: const Icon(Icons.home, color: Color(0xFF582218)),
            title: "Home",
            context: context,
            page: const HomePage(),
          ),
          _buildDrawerItem(
            icon: const Icon(Icons.settings, color: Color(0xFF582218)),
            title: "Settings",
            context: context,
            page: const SettingsPage(),
          ),
          _buildDrawerItem(
            icon: Image.asset(
              'assets/rocketchat-brands-solid 1.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            title: "Ask",
            context: context,
            page: ChatListScreen(),
          ),
          _buildDrawerItem(
            icon: const Icon(Icons.info, color: Color(0xFF582218)),
            title: "About",
            context: context,
            page: const AboutPage(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF582218)),
              title: const Text("Logout"),
              onTap: () => _logout(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required Widget icon,
    required String title,
    required BuildContext context,
    required Widget page,
  }) {
    return ListTile(
      leading: icon,
      title: Text(title),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
    );
  }
}
