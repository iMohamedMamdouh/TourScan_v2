import 'package:flutter/material.dart';

void showsnackbar(BuildContext context, String message,
    {Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
    ),
  );
}
