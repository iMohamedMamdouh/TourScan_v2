import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/NewPassord.dart'; // Make sure this screen is implemented
import 'package:tourscan/generated/l10n.dart';

import '../Widgets/Customtext.dart'; // Assuming this widget is implemented
import '../helper/show_snack_bar.dart'; // Assuming this helper is implemented
import 'Login.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String? email;
  bool isLoading = false;
  bool isButtonEnabled = false; // Button is disabled until email is entered
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        // ✅ Check if email exists in Firebase Authentication
        var methods = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(email!.trim());
        if (methods.isEmpty || !methods.contains("password")) {
          showsnackbar(
              context, 'Email not found or does not support password reset.');
          setState(() => isLoading = false);
          return;
        }

        // ✅ Check if the email exists in Firestore
        var userSnapshot = await FirebaseFirestore.instance
            .collection('users') // Make sure the collection is correct
            .where('email', isEqualTo: email!.trim())
            .get();

        if (userSnapshot.docs.isEmpty) {
          showsnackbar(context, 'Email not found in Firestore.');
          setState(() => isLoading = false);
          return;
        }

        // ✅ Send password reset email from FirebaseAuth
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: email!.trim());
        showsnackbar(context, 'Check your email for the reset link.');

        // Navigate to NewPasswordScreen to change the password
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NewPasswordScreen(email: email!)),
        );
      } on FirebaseAuthException catch (e) {
        showsnackbar(context, 'Error: ${e.message}');
      } catch (e) {
        showsnackbar(context, 'Something went wrong.');
      }

      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text(
                S.of(context).ForgetPassword,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                S.of(context).EnterYourRegisteredEmailBelow,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              /// 📧 Email input field
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) {
                  setState(() {
                    email = value;
                    isButtonEnabled = value.isNotEmpty;
                  });
                },
                hintText: S.of(context).EmailAddress,
              ),
              const SizedBox(height: 20),

              /// 🔘 Reset password button
              GestureDetector(
                onTap: isButtonEnabled ? resetPassword : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        isButtonEnabled ? const Color(0xFF582218) : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: kSecondaryColor)
                      : Text(
                          S.of(context).Submit,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              /// 🔙 Go back to login screen
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: S.of(context).RememberThePassword,
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: S.of(context).login,
                          style: TextStyle(
                              color: Color(0xFF582218),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
