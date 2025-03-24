import 'package:flutter/material.dart';
import '../atoms/psychometric_button.dart';
import '../molecules/psychometric_image.dart';

class PsychometricContent extends StatefulWidget {
  const PsychometricContent({super.key});

  @override
  _PsychometricContentState createState() => _PsychometricContentState();
}

class _PsychometricContentState extends State<PsychometricContent> {
  bool _showImage = false;

  void _toggleImage() {
    setState(() {
      _showImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PsychometricButton(onTap: _toggleImage),
        const SizedBox(
          height: 20,
        ),
        PsyhcometricImage(isVisible: _showImage),
      ],
    );
  }
}
