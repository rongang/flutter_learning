import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationPage4 extends StatefulWidget {
  @override
  _AnimationPage4State createState() => _AnimationPage4State();
}

class _AnimationPage4State extends State<AnimationPage4>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  double dataSet;
  AnimationController _controller;
  BarTween tween;

  @override
  void initState() {
    dataSet = 30;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..addListener(() {
            setState(() {
            });
          });
    tween = BarTween(Bar(0.0,RandomColor.random()),Bar(100.0,RandomColor.random()));
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
      dataSet = random.nextDouble() * 400.clamp(20.0, 400.0);
      tween = BarTween(Bar(0.0,RandomColor.random(),),Bar(dataSet,RandomColor.random()));
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
class BarChart{
  List<Bar> bars = [];
}