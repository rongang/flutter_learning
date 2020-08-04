import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationPage3 extends StatefulWidget {
  @override
  _AnimationPage3State createState() => _AnimationPage3State();
}

class _AnimationPage3State extends State<AnimationPage3>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  double dataSet;
  AnimationController _controller;
  BarTween tween;

  @override
  void initState() {
    dataSet = 30;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
            setState(() {
            });
          });
    tween = BarTween(Bar(0.0),Bar(100.0));
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
      tween = BarTween(Bar(0.0),Bar(dataSet));
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
              painter: BarChartPainter(tween.animate(_controller)),
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

  BarChartPainter(this.animation) : super(repaint: animation);
  Animation<Bar> animation;

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromCenter(
            center: size.center(Offset.zero),
            width: width,
            height: animation.value.height),
        p);
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => false;
}

class Bar {
  double height;

  Bar(this.height);

  static Bar lerp(Bar begin, Bar end, double h) {
    return Bar(lerpDouble(begin.height, end.height, h));
  }
}

class BarTween extends Tween<Bar> {
  BarTween(begin, end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) {
    return Bar.lerp(begin, end, t);
  }
}
