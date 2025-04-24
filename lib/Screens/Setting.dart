import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/generated/l10n.dart';

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
  bool _obscurePassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isPasswordChangeVisible = false;
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

    if (currentPasswordController.text.isNotEmpty) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: currentPasswordController.text,
        );
        await user!.reauthenticateWithCredential(credential);
      } catch (e) {
        _showMessage(S.of(context).currentPasswordIncorrect, isError: true);
        return;
      }
    }

    controllers.forEach((key, controller) {
      if (key != 'password' && controller.text != userData![key]) {
        updatedData[key] = controller.text;
      }
    });

    if (newPasswordController.text.isNotEmpty &&
        newPasswordController.text != "********") {
      if (newPasswordController.text != confirmPasswordController.text) {
        _showMessage(S.of(context).passwordsDoNotMatch, isError: true);
        return;
      }

      try {
        await user!.updatePassword(newPasswordController.text);
        updatedData['password'] = newPasswordController.text;
      } catch (e) {
        _showMessage("${S.of(context).updatePasswordFailed} $e", isError: true);
        return;
      }
    }

    if (updatedData.isNotEmpty) {
      await _firestore.collection('users').doc(user!.uid).update(updatedData);
      setState(() {
        userData!.addAll(updatedData);
      });
      _showMessage(S.of(context).dataUpdatedSuccessfully);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green),
    );
  }

  Widget _buildEditableField(
      BuildContext context, String labelKey, String fieldKey,
      {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelKey,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controllers[fieldKey],
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: kSecondaryColor, width: 2),
            ),
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
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: kSecondaryColor, width: 2),
            ),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () => toggleVisibility(),
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(S.of(context).settings,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildEditableField(context, "FullName", "fullName"),
                  _buildEditableField(context, "Email", "email"),
                  _buildEditableField(context, "PhoneNumber", "phoneNumber",
                      isNumber: true),
                  _buildEditableField(context, "Address", "address"),
                  _buildEditableField(context, "Age", "age", isNumber: true),
                  _buildEditableField(context, "Gender", "gender"),
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
                          ? S.of(context).hideChangePassword
                          : S.of(context).ChangePassword,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  if (_isPasswordChangeVisible) ...[
                    _buildPasswordField(
                      S.of(context).currentPassword,
                      currentPasswordController,
                      _obscurePassword,
                      () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    _buildPasswordField(
                      S.of(context).NewPassword,
                      newPasswordController,
                      _obscureNewPassword,
                      () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                    _buildPasswordField(
                      S.of(context).ConfirmPassword,
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
                  ElevatedButton(
                    onPressed: _updateAllData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF582218),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12),
                    ),
                    child: Text(S.of(context).UpdateData,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}
