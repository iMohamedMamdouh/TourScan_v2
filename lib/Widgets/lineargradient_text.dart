import 'package:flutter/material.dart';

import '../Constans/Const.dart';

class LinearGradientText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const LinearGradientText({
    required this.text,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            kSecondaryColor,
            kWhiteColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 14,
          fontFamily: fontFamily ?? 'inter',
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
