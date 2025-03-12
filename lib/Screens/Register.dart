import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create an account",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Text(
                "Join us and explore new possibilities!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => fullName = value,
                labelText: 'Full Name',
                hintText: '',
              ),
              const SizedBox(height: 16),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => phoneNumber = value,
                labelText: 'Phone Number',
                hintText: '',
              ),
              const SizedBox(height: 16),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => address = value,
                labelText: 'Address',
                hintText: '',
              ),
              const SizedBox(height: 16),
              CustomFormTextField(
                obscureText: false,
                onChanged: (value) => email = value,
                labelText: 'Email Address',
                hintText: '',
              ),
              const SizedBox(height: 16),
              CustomFormTextField(
                obscureText: true,
                onChanged: (value) => password = value,
                labelText: 'Password',
                hintText: '',
              ),
              const SizedBox(height: 16),
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
                      labelText: 'Age',
                      hintText: '',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          labelText: "Gender", border: OutlineInputBorder()),
                      items: ['Male', 'Female']
                          .map((gender) => DropdownMenuItem(
                              value: gender, child: Text(gender)))
                          .toList(),
                      onChanged: (value) => gender = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: signUp,
                text: isLoading ? 'Creating Account...' : 'Create Account',
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
                      child: Image.asset('assets/google_logo.png',
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text("Log In",
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
