import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationPage2 extends StatefulWidget {
  @override
  _AnimationPage2State createState() => _AnimationPage2State();
}

class _AnimationPage2State extends State<AnimationPage2>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  double dataSet;
  AnimationController _controller;
  double startHeight;
  double endHeight = 30;
  Animation tween;

  @override
  void initState() {
    dataSet = 30;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
//        changeDate();
            setState(() {
              dataSet = tween.value;
//              dataSet = lerpDouble(
//                startHeight,endHeight,_controller.value
//              );
            });
          });
    tween = Tween(begin: 1.0, end: dataSet).animate(_controller);
    _controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  changeDate() {
    setState(() {
      dataSet = random.nextDouble() * 100.clamp(20.0, 100.0);
      tween = Tween(begin: 1.0, end: dataSet).animate(_controller);
      _controller.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画示例一'),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CustomPaint(
              size: Size(100, 100),
              painter: BarChartPainter(tween),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          changeDate();
        },
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  static const width = 10.0;

  BarChartPainter(this.animation):super(repaint:animation);
  Animation animation;

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromCenter(
            center: size.center(Offset.zero), width: width, height: animation.value),
        p);
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => false;
}
