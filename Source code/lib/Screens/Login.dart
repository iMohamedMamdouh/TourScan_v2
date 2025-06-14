import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tourscan/Screens/Home.dart';
import 'package:tourscan/generated/l10n.dart';
import 'package:tourscan/utils/animation_utils.dart';

import '../MODELS/AuthService.dart';
import '../Widgets/Customtext.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import 'Forgetpassword.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? email, password;
  bool isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      email = email?.trim();
      password = password?.trim();

      if (email == null ||
          email!.isEmpty ||
          password == null ||
          password!.isEmpty) {
        showsnackbar(context, S.of(context).PleaseEnterEmailAndPassword);
        return;
      }

      setState(() => isLoading = true);

      try {
        await FirebaseAuth.instance.signOut();

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);

        User? user = userCredential.user;

        if (user != null) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          if (!userDoc.exists) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'uid': user.uid,
              'email': user.email,
              'createdAt': FieldValue.serverTimestamp(),
            });
          }

          Navigator.pushReplacement(
            context,
            CustomPageRoute(
              child: const HomePage(),
              transitionType: PageTransitionType.fade,
            ),
          );
        }
      } on FirebaseAuthException catch (ex) {
        setState(() => isLoading = false);
        if (ex.code == 'user-not-found') {
          showsnackbar(context, S.of(context).UserNotFound);
        } else if (ex.code == 'wrong-password') {
          showsnackbar(context, S.of(context).WrongPassword);
        } else {
          showsnackbar(context, 'Login error: ${ex.message}');
        }
      } catch (e) {
        setState(() => isLoading = false);
        showsnackbar(context, 'Error occurred: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    S.of(context).LoginToYourAccount,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ).fadeIn(delay: const Duration(milliseconds: 200)),
                  Text(
                    S.of(context).WelcomeBackPleaseEnterYourDetails,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ).fadeIn(delay: const Duration(milliseconds: 400)),
                  const SizedBox(height: 24),
                  Text(S.of(context).EmailAddress,
                          style: const TextStyle(color: Colors.black))
                      .slideIn(
                    delay: const Duration(milliseconds: 600),
                    direction: SlideDirection.left,
                  ),
                  const SizedBox(height: 6),
                  CustomFormTextField(
                    hintText: S.of(context).EnterYourEmail,
                    obscureText: false,
                    onChanged: (data) => email = data,
                  ).slideIn(
                    delay: const Duration(milliseconds: 700),
                    direction: SlideDirection.right,
                  ),
                  const SizedBox(height: 16),
                  Text(S.of(context).Password,
                          style: const TextStyle(color: Colors.black))
                      .slideIn(
                    delay: const Duration(milliseconds: 800),
                    direction: SlideDirection.left,
                  ),
                  const SizedBox(height: 6),
                  CustomFormTextField(
                    hintText: S.of(context).EnterYourPassword,
                    obscureText: true,
                    onChanged: (data) => password = data,
                  ).slideIn(
                    delay: const Duration(milliseconds: 900),
                    direction: SlideDirection.right,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            child: const ForgetPasswordScreen(),
                            transitionType: PageTransitionType.slideRight,
                          ),
                        );
                      },
                      child: Text(
                        S.of(context).ForgetPassword,
                        style: const TextStyle(
                          color: Color(0xFF582218),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).fadeIn(delay: const Duration(milliseconds: 1000)),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: S.of(context).login,
                    onTap: _login,
                  ).scaleIn(
                    delay: const Duration(milliseconds: 1100),
                    curve: Curves.elasticOut,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () async {
                        setState(() => isLoading = true);

                        try {
                          await FirebaseAuth.instance.signOut();

                          AuthService authService = AuthService();
                          User? user = await authService.signInWithGoogle();

                          if (user != null) {
                            Navigator.pushReplacement(
                              context,
                              CustomPageRoute(
                                child: const HomePage(),
                                transitionType: PageTransitionType.fade,
                              ),
                            );
                          } else {
                            showsnackbar(
                                context, S.of(context).GoogleSignInFailed);
                          }
                        } catch (e) {
                          showsnackbar(context,
                              '${S.of(context).GoogleSignInError}: ${e.toString()}');
                        }

                        setState(() => isLoading = false);
                      },
                      icon: SvgPicture.asset(
                        "assets/Google_Logo.svg",
                        width: 24,
                        height: 24,
                      ),
                      label: Text(
                        S.of(context).SignInWithGoogle,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ).scaleIn(
                    delay: const Duration(milliseconds: 1200),
                    curve: Curves.elasticOut,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).DontHaveAnAccount,
                          style: const TextStyle(color: Colors.black)),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageRoute(
                              child: const SignUpScreen(),
                              transitionType: PageTransitionType.slideRight,
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).SignUp,
                          style: const TextStyle(
                            color: Color(0xFF582218),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ).fadeIn(delay: const Duration(milliseconds: 1300)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
