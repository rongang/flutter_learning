import 'package:flutter/material.dart';

class ClipRectDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        clipper: BottomClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
//    path.lineTo(0, 0);
    path.lineTo(0, size.height - 70);
    Offset firstControlPointBegin = Offset(size.width / 4, size.height-140);
    Offset firstControlPointEnd = Offset(size.width/2, size.height - 70);
    path.quadraticBezierTo(firstControlPointBegin.dx, firstControlPointBegin.dy,
        firstControlPointEnd.dx, firstControlPointEnd.dy);
    path.lineTo(size.width/2, size.height -70);
    Offset secondControlPointBegin = Offset(size.width * (3/4), size.height);
    Offset secondControlPointEnd = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPointBegin.dx, secondControlPointBegin.dy,
        secondControlPointEnd.dx, secondControlPointEnd.dy);
    path.lineTo(size.width, size.height - 70);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
