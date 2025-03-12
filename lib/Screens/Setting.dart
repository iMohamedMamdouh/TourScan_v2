import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  User? user;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  bool _obscurePassword = true; // Changed to mutable variable
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final bool _obscureCurrentPassword = true;
  bool _isPasswordChangeVisible = false; // State to toggle visibility
  File? _imageFile;
  Map<String, TextEditingController> controllers = {};

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user!.uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() as Map<String, dynamic>;
          isLoading = false;
          controllers = {
            'fullName': TextEditingController(text: userData!['fullName']),
            'email': TextEditingController(text: userData!['email']),
            'phoneNumber':
                TextEditingController(text: userData!['phoneNumber']),
            'address': TextEditingController(text: userData!['address']),
            'age': TextEditingController(text: userData!['age'].toString()),
            'gender': TextEditingController(text: userData!['gender']),
            'password': TextEditingController(text: "********"),
          };
        });
      }
    }
  }

  void _updateAllData() async {
    Map<String, dynamic> updatedData = {};

    // Validate the current password
    if (currentPasswordController.text.isNotEmpty) {
      try {
        // Re-authenticate the user to verify the current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: currentPasswordController.text,
        );
        await user!.reauthenticateWithCredential(credential);
      } catch (e) {
        _showMessage("Current password is incorrect.", isError: true);
        return;
      }
    }

    controllers.forEach((key, controller) {
      if (key != 'password' && controller.text != userData![key]) {
        updatedData[key] = controller.text;
      }
    });

    // Check if new password is valid
    if (newPasswordController.text.isNotEmpty &&
        newPasswordController.text != "********") {
      if (newPasswordController.text != confirmPasswordController.text) {
        _showMessage("New password and confirmation do not match.",
            isError: true);
        return;
      }

      try {
        await user!.updatePassword(newPasswordController.text);
        updatedData['password'] = newPasswordController.text;
      } catch (e) {
        _showMessage("Failed to update password: $e", isError: true);
        return;
      }
    }

    // Update user data in Firestore
    if (updatedData.isNotEmpty) {
      await _firestore.collection('users').doc(user!.uid).update(updatedData);
      setState(() {
        userData!.addAll(updatedData);
      });
      _showMessage("All data updated successfully!");
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green),
    );
  }

  Widget _buildEditableField(String label, String fieldKey,
      {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controllers[fieldKey],
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller,
      bool obscureText, Function toggleVisibility) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                toggleVisibility();
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildEditableField("Full Name", "fullName"),
                  _buildEditableField("Email", "email"),
                  _buildEditableField("Phone Number", "phoneNumber",
                      isNumber: true),
                  _buildEditableField("Address", "address"),
                  _buildEditableField("Age", "age", isNumber: true),
                  _buildEditableField("Gender", "gender"),

                  // Password change button
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordChangeVisible = !_isPasswordChangeVisible;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF582218),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                    child: Text(
                        _isPasswordChangeVisible
                            ? "Hide Password Change"
                            : "Change Password",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),

                  // Show password change fields if visible
                  if (_isPasswordChangeVisible) ...[
                    // Current Password field
                    _buildPasswordField(
                      "Current Password",
                      currentPasswordController,
                      _obscurePassword,
                      () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),

                    // New Password field
                    _buildPasswordField(
                      "New Password",
                      newPasswordController,
                      _obscureNewPassword,
                      () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),

                    // Confirm Password field
                    _buildPasswordField(
                      "Confirm Password",
                      confirmPasswordController,
                      _obscureConfirmPassword,
                      () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ],

                  const SizedBox(height: 15),

                  // Update Data button
                  ElevatedButton(
                    onPressed: _updateAllData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF582218),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12),
                    ),
                    child: const Text("Update Data",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
