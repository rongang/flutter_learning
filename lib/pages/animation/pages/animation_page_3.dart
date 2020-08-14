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
  AnimationController _controller;
  BarTween tween;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {
            });
          });
    tween = BarTween(Bar.empty(),Bar.random());
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  changeDate() {
    setState(() {
      tween = BarTween(tween.evaluate(_controller),Bar.random());
      _controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画示例三'),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            CustomPaint(
              size: Size(100, 400),
              painter: BarChartPainter(tween.animate(_controller),),
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
  static const width = 20.0;

  BarChartPainter(this.animation) : super(repaint: animation);
  Animation<Bar> animation;

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = animation.value.color
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

  Color color;

  Bar(this.height,this.color);

  factory Bar.random(){
    return Bar(
      Random().nextDouble()*400.0.clamp(20.0, 400.0),
      RandomColor.random()
    );
  }

  factory Bar.empty(){
    return Bar(0.0,Colors.transparent);
  }

  static Bar lerp(Bar begin, Bar end, double h) {
    return Bar(lerpDouble(begin.height, end.height, h),Color.lerp(begin.color, end.color, h));
  }
}

class BarTween extends Tween<Bar> {
  BarTween(begin, end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) {
    return Bar.lerp(begin, end, t);
  }
}

class RandomColor{
  static Color random() => Colors.accents[Random().nextInt(15)];
}