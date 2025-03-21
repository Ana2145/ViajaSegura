import 'package:flutter/material.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/logo.png', width: 150),
        SizedBox(height: 10),
      ],
    );
  }
}
