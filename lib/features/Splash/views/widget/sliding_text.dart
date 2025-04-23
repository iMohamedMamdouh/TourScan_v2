import 'package:flutter/material.dart';

import '../../../../Widgets/lineargradient_text.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.animationController,
    required this.slidingAnimation,
    required this.fadeAnimation,
  });

  final AnimationController animationController;
  final Animation<Offset> slidingAnimation;
  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: const Column(
              children: [
                LinearGradientText(
                  text: 'T O U R  S C A N',
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
                LinearGradientText(
                  text: 'E G Y P T I O N  M U E S U M ',
                  fontSize: 20,
                ),
                LinearGradientText(
                  text: "★ ★ ★",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
