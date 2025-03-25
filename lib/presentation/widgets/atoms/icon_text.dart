import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final double textSize;
  final Color iconColor;

  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconSize = 18,
    this.textSize = 12,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        Positioned(
          top: -4,
          right: -6,
          child: Text(text,
              style: TextStyle(
                fontSize: textSize,
                color: const Color(0xFF7C4A36),
                fontWeight: FontWeight.bold,
              )),
        )
      ],
    );
  }
}
