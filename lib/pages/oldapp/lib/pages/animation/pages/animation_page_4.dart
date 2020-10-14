import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationPage4 extends StatefulWidget {
  @override
  _AnimationPage4State createState() => _AnimationPage4State();
}

class _AnimationPage4State extends State<AnimationPage4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Colors.blue[300]
        ),
        child: CustomPaint(
          painter: MyPainter(),
          child: Icon(Icons.timer,size: 100,),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('size:$size');
    Paint p = Paint();
    p.color = Colors.white;
    canvas.drawOval(Rect.fromCenter(center:size.center(Offset.zero),width: 300,height: 300), p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
