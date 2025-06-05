import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/generated/l10n.dart';

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
        showsnackbar(context, S.of(context).passwordsDoNotMatch);
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
        showsnackbar(context, S.of(context).dataUpdatedSuccessfully);

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
    // Determine text direction based on language
    bool isArabic = S.of(context).languageCode == 'ar';
    TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
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
                  S.of(context).NewPassword,
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textDirection: textDirection,
                ),
                Text(
                  isArabic
                      ? "أدخل كلمة المرور الجديدة أدناه"
                      : "Enter your new password below",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textDirection: textDirection,
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
                  hintText: S.of(context).NewPassword,
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
                  hintText: S.of(context).ConfirmPassword,
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
                      color: isButtonEnabled
                          ? const Color(0xFF582218)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: kSecondaryColor,
                          )
                        : Text(
                            isArabic ? "تحديث كلمة المرور" : "Update Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: textDirection,
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                /// 🔙 Back to Login Link
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: RichText(
                      textDirection: textDirection,
                      text: TextSpan(
                        text: isArabic ? "العودة إلى " : "Back to ",
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
      ),
    );
  }
}
