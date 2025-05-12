import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.isArabic,
  });

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: isArabic ? null : 10,
      right: isArabic ? 10 : null,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: const Offset(0, 4),
                blurRadius: 6.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF582218),
          ),
        ),
      ),
    );
  }
}
