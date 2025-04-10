import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatternRow extends StatelessWidget {
  final Color color;
  final bool isReversed;
  final bool isTransparent;
  final int height;

  const PatternRow({
    super.key,
    required this.color,
    this.isReversed = false,
    this.isTransparent = true,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final patternHeight = MediaQuery.of(context).size.height / height;
    final patternWidth = patternHeight * 2.67;

    final patternCount = ((screenWidth / patternWidth).floor() + 2 | 1);
    final offset = (screenWidth - patternWidth * patternCount) / 2;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Transform.translate(
        offset: Offset(offset, 0),
        child: Row(
          children: List.generate(
            patternCount,
            (_) => Opacity(
              opacity: isTransparent ? 0.15 : 1,
              child: Transform.rotate(
                angle: isReversed ? 3.14159 : 0,
                child: SvgPicture.asset(
                  'assets/images/pattern.svg',
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  height: patternHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
