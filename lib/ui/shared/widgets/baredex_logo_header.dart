import 'package:flutter/material.dart';

class BaredexLogoHeader extends StatefulWidget {
  @override
  _BaredexLogoHeaderState createState() => _BaredexLogoHeaderState();
}

class _BaredexLogoHeaderState extends State<BaredexLogoHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150.0,
          width: double.infinity,
          child: ClipPath(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/baredex-logo-big.png',
                  height: 100,
                  width: 200,
                ),
              ),
            ),
            clipper: HeaderColors(),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

class HeaderColors extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 45);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
