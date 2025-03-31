import 'package:flutter/material.dart';

class CarImage extends StatelessWidget {
  final double size;
  final String color;
  const CarImage({super.key, this.size = 80.0, this.color = '#FFFFFF'});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/car.png',
      width: size,
      colorBlendMode: BlendMode.modulate,
    );
  }
}
