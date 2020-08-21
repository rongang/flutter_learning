import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationPage1 extends StatefulWidget {
  @override
  _AnimationPage1State createState() => _AnimationPage1State();
}

class _AnimationPage1State extends State<AnimationPage1>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  double dataSet;
  AnimationController _controller;
  double startHeight;
  double endHeight = 30;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..addListener(() {
//        changeDate();
            setState(() {
//              dataSet = _controller.value * 100;
              dataSet = lerpDouble(
                startHeight,endHeight,_controller.value
              );
            });
          })
          ..repeat(reverse: true);
    dataSet = 30;
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
              painter: BarChartPainter(dataSet),
            ),
            CustomPaint(
              size: Size(100, 100),
              painter: BarChartPainter(dataSet),
            ),
            CustomPaint(
              size: Size(100, 100),
              painter: BarChartPainter(dataSet),
            ),
            CustomPaint(
              size: Size(100, 100),
              painter: BarChartPainter(dataSet),
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
  final double data;

  BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromCenter(
            center: size.center(Offset.zero), width: width, height: data),
        p);
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => data != oldDelegate.data;
}
