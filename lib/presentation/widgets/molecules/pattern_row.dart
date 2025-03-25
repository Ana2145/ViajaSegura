import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatternRow extends StatelessWidget {
  final bool isReversed;

  const PatternRow({
    super.key,
    this.isReversed = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final patternHeight = MediaQuery.of(context).size.height / 6;
    final patternWidth = patternHeight * 2.67;

    final patternCount = ((screenWidth / patternWidth).floor() + 2 | 1);
    final offset = (screenWidth - patternWidth * patternCount) / 2;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Transform.translate(
        offset: Offset(offset, 0),
        child: Row(
          children: List.generate(
              patternCount,
              (_) => Opacity(
                    opacity: 0.15,
                    child: Transform.rotate(
                      angle: isReversed ? 3.14159 : 0,
                      child: SvgPicture.asset(
                        'assets/images/pattern.svg',
                        height: patternHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
