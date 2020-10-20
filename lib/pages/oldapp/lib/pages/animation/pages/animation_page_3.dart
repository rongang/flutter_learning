import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/ScreenUtil.dart';

class AnimationPage3 extends StatefulWidget {
  @override
  _AnimationPage3State createState() => _AnimationPage3State();
}

class _AnimationPage3State extends State<AnimationPage3>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.repeat();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  var list = List.generate(100, (index) => Snow());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('画板'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            color: Colors.blue[300],
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[400],Colors.white],
            stops: [0.8,0.9]
          )
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return CustomPaint(
              painter: MyCustomPainter(list),
            );
          },
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final List list;

  MyCustomPainter(this.list);
  @override
  void paint(Canvas canvas, Size size) {
    print('size:$size');

    var startPoint = size.center(Offset(-30, 20));
    var controlPoint1 = Offset((size.width / 4) + 70, (size.height / 3) + 160);
    var controlPoint2 =
        Offset((3 * size.width / 4) - 70, (size.height / 3) + 160);
    var endPoint = size.center(Offset(30, 20));

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    Paint p = Paint();
    p.color = Colors.deepOrangeAccent;
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 3;

    canvas.drawCircle(
        size.center(Offset.zero), 80, Paint()..color = Colors.white);
    canvas.drawCircle(size.center(Offset(-30, -20)), 10, Paint());
    canvas.drawCircle(size.center(Offset(30, -20)), 10, Paint());

    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(0, 220)), width: 300, height: 400),
        Paint()..color = Colors.white);
    canvas.drawPath(path, p);
    Paint snowPaint = Paint();
    snowPaint.color = Colors.white;
    list.forEach((snow) {
      snow.fall();
      canvas.drawCircle(Offset(snow.dx, snow.dy), snow.radius, snowPaint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Snow {
  double radius = Random().nextDouble()*2+2;
  double dx = Random().nextDouble()*ScreenUtil.screenWidth;
  double dy = Random().nextDouble()*800;
  double speed = Random().nextDouble()*3+2;
  fall(){
    dy += speed;
    if(dy>700) {
      dy = 0;
      radius = Random().nextDouble()*2+2;
      dx = Random().nextDouble()*ScreenUtil.screenWidth;
    }
  }
}
