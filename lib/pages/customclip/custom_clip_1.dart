import 'package:flutter/material.dart';

class CustomClip1 extends StatefulWidget {
  @override
  _CustomClip1State createState() => _CustomClip1State();
}

class _CustomClip1State extends State<CustomClip1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          padding: const EdgeInsets.all(10),
          color: Colors.blue[500],
          child: ClipPath(
            clipper: MyClipPath(),
            child: Container(
              height: 100,
              width: 200,
              child: Icon(Icons.star),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[100],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 class MyClipPath extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    print('size: $size');
    Path p = Path();
    p.lineTo(30, 0);
    p.quadraticBezierTo(15, 5, 20, 20);
    p.lineTo(0, size.height/6);
    p.lineTo(20, size.height/6*2);
    p.lineTo(20, size.height-20);
    p.quadraticBezierTo(20, size.height, 50, size.height);
    p.lineTo(size.width, size.height);
    p.lineTo(size.width, 0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper ) {
    return false;
  }

 }