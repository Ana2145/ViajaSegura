import 'package:flutter/material.dart';

class BackButtonAtoms extends StatelessWidget {
  final VoidCallback onTap;
  const BackButtonAtoms({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: 20,
      child: GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.arrow_back_ios,
          size: 30,
          color: Color(0xFF773357),
        ),
      ),
    );
  }
}
