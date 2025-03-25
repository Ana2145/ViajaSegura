import 'package:flutter/material.dart';

class PsyhcometricImage extends StatelessWidget {
  final bool isVisible;
  const PsyhcometricImage({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isVisible ? 1.0 : 00,
      child: isVisible
          ? Image.asset(
              "assets/images/psychometric_exam.png",
              width: MediaQuery.of(context).size.width * 0.8,
            )
          : const SizedBox.shrink(),
    );
  }
}
