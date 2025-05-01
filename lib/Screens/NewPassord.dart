import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';

import '../Widgets/Customtext.dart';
import '../helper/show_snack_bar.dart';
import 'Login.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({super.key, required this.email});

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  String? newPassword;
  String? confirmPassword;
  bool isLoading = false;
  bool isButtonEnabled = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> updatePassword() async {
    if (formKey.currentState!.validate()) {
      if (newPassword != confirmPassword) {
        showsnackbar(context, "Passwords do not match");
        return;
      }

      setState(() => isLoading = true);

      try {
        // 🔍 Check if the email is registered in Firebase
        List<String> signInMethods = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(widget.email);
        if (signInMethods.isEmpty) {
          showsnackbar(context, "Email is not registered");
          setState(() => isLoading = false);
          return;
        }

        // 🔄 Sign in the user to update the password
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          showsnackbar(context, "User is not logged in");
          setState(() => isLoading = false);
          return;
        }

        // 🔑 Update the password
        await user.updatePassword(newPassword!);
        showsnackbar(context, 'Password changed successfully');

        // ⏩ Navigate the user to the Login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } on FirebaseAuthException catch (e) {
        showsnackbar(context, 'Error: ${e.message}');
      } catch (e) {
        showsnackbar(context, 'Something went wrong');
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
              const Text(
                "New Password",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Enter your new password below",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              /// 🔑 New Password Input Field
              CustomFormTextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    newPassword = value;
                    isButtonEnabled =
                        value.isNotEmpty && confirmPassword != null;
                  });
                },
                hintText: 'New Password',
              ),
              const SizedBox(height: 20),

              /// 🔐 Confirm Password Input Field
              CustomFormTextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value;
                    isButtonEnabled = value.isNotEmpty && newPassword != null;
                  });
                },
                hintText: 'Confirm Password',
              ),
              const SizedBox(height: 20),

              /// 🔘 Update Password Button
              GestureDetector(
                onTap: isButtonEnabled ? updatePassword : null,
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
                      ? const CircularProgressIndicator(
                          color: kSecondaryColor,
                        )
                      : const Text(
                          "Update Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              /// 🔙 Back to Login Link
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Back to ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Login",
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
