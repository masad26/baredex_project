import 'dart:ui';
import 'package:flutter/material.dart';

class BaredexLogo extends StatelessWidget {
  final double size;
  final Color color;

  const BaredexLogo({
    Key key,
    @required this.size,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(this.color, BlendMode.modulate),
        child: Image.asset('assets/logos/logo_white.png'),
      ),
    );
  }
}
