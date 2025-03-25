import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final logoHeight = MediaQuery.of(context).size.height / 4;
    return SvgPicture.asset('assets/images/logo.svg', height: logoHeight);
  }
}
