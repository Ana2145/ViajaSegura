import 'package:flutter/material.dart';
import '../widgets/atoms/panic_button.dart';
import '../widgets/atoms/help_button.dart';

class PanicScreen extends StatelessWidget {
  const PanicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 246, 191, 204),
              Color.fromARGB(255, 244, 226, 229),
            ],
          ),
        ),
        child: const Stack(
          children: [
            Center(
              child: PanicButton(),
            ),
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,
              child: HelpButton(),
            ),
          ],
        ),
      ),
    );
  }
}
