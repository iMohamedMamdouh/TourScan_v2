import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/generated/l10n.dart';

class CustomFormTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final bool obscureText;
  final String hintText;

  const CustomFormTextField({
    super.key,
    this.onChanged,
    required this.obscureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data) {
        if (data == null || data.isEmpty) {
          return S.of(context).fieldIsRequired;
        }
        return null;
      },
      onChanged: onChanged,
      cursorColor: kSecondaryColor,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12.0,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey, // 👈 Set your hint text color here
          fontSize: 12.0,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: kSecondaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
