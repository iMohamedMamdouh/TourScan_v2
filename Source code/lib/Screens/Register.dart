import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/generated/l10n.dart';

import '../MODELS/AuthService.dart';
import '../Widgets/Customtext.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import 'Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? fullName, phoneNumber, address, email, password, gender;
  int? age;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    if (email == null ||
        password == null ||
        email!.isEmpty ||
        password!.isEmpty) {
      showsnackbar(context, 'Please enter email and password');
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': fullName ?? '',
        'phoneNumber': phoneNumber ?? '',
        'address': address ?? '',
        'email': email!,
        'password': password!, // تم إضافة حفظ الباسورد في Firestore
        'age': age ?? 0,
        'gender': gender ?? 'Not Specified',
        'createdAt': DateTime.now(),
      });

      showsnackbar(context, 'Account created successfully');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } on FirebaseAuthException catch (e) {
      showsnackbar(context, 'Error: ${e.message}');
    } catch (e) {
      showsnackbar(context, 'Something went wrong');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                S.of(context).CreateAnAccount,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                S.of(context).JoinUsAndExplore,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).FullName,
                    style: TextStyle(color: Colors.black)),
              ),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => fullName = value,
                hintText: S.of(context).FullName,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).PhoneNumber,
                    style: TextStyle(color: Colors.black)),
              ),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => phoneNumber = value,
                hintText: S.of(context).PhoneNumber,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).Address,
                    style: TextStyle(color: Colors.black)),
              ),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => address = value,
                hintText: S.of(context).Address,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).EmailAddress,
                    style: TextStyle(color: Colors.black)),
              ),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => email = value.trim(),
                hintText: S.of(context).Email,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).Password,
                    style: TextStyle(color: Colors.black)),
              ),
              CustomFormTextField(
                obscureText: true,
                onChanged: (value) => password = value.trim(),
                hintText: S.of(context).Password,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(S.of(context).Age,
                    style: TextStyle(color: Colors.black)),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomFormTextField(
                      obscureText: false,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          age = int.tryParse(value);
                        } else {
                          age = null;
                        }
                      },
                      hintText: S.of(context).Age,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: S.of(context).Gender,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: kSecondaryColor, width: 2),
                      ),
                    ),
                    items: [S.of(context).Male, S.of(context).Female]
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) => gender = value,
                  )),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: signUp,
                text: isLoading
                    ? S.of(context).CreateAccountDot
                    : S.of(context).CreateAccount,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("OR", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  setState(() => isLoading = true);
                  AuthService authService = AuthService();
                  User? user = await authService.signInWithGoogle();

                  if (user != null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  } else {
                    showsnackbar(context, 'Google Sign-In failed');
                  }
                  setState(() => isLoading = false);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset('assets/Google_Logo.svg',
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).AlreadyHaveAnAccount,
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: Text(S.of(context).login,
                        style: TextStyle(
                            color: Color(0xFF582218),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
