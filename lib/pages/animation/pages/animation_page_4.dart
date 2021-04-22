import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationPage4 extends StatefulWidget {
  @override
  _AnimationPage4State createState() => _AnimationPage4State();
}

class _AnimationPage4State extends State<AnimationPage4> with SingleTickerProviderStateMixin {
  Random random = Random();
  late AnimationController _controller;
  late BarCharTween tween;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1))
      ..addListener(() {
//            print('${_controller.value}');
//            print('${tween.evaluate(_controller).bars[0].height}');
        setState(() {});
      });
    tween = BarCharTween(BarChart.empty(), BarChart.random());
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
      tween = BarCharTween(tween.evaluate(_controller), BarChart.random());
      _controller.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画示例四'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              size: Size(200, 400),
              painter: BarChartPainter(
                tween.animate(_controller),
              ),
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
  Animation<BarChart> animation;
  int i = 0;

  @override
  void paint(Canvas canvas, Size size) {
    for (i = 0; i < animation.value.bars.length; i++) {
      Paint p = Paint()
        ..color = animation.value.bars[i].color
        ..style = PaintingStyle.fill;
      canvas.drawRect(
          Rect.fromLTWH(
            30.0 * i,
            (size.height - animation.value.bars[i].height), //0
            width,
            animation.value.bars[i].height,
          ),
          p);
    }
  }

  @override
  bool shouldRepaint(BarChartPainter oldDelegate) => false;
}

class Bar {
  double height;

  Color color;

  Bar(this.height, this.color);

  factory Bar.random() {
    return Bar(Random().nextDouble() * 400.0.clamp(20.0, 400.0), RandomColor.random());
  }

  factory Bar.empty() {
    return Bar(0.0, Colors.transparent);
  }

  static Bar lerp(Bar begin, Bar end, double h) {
    return Bar(lerpDouble(begin.height, end.height, h)!, Color.lerp(begin.color, end.color, h)!);
  }
}

class BarTween extends Tween<Bar> {
  BarTween(begin, end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) {
    return Bar.lerp(begin!, end!, t);
  }
}

class BarCharTween extends Tween<BarChart> {
  BarCharTween(begin, end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) {
    return BarChart.lerp(begin!, end!, t);
  }
}

class RandomColor {
  static Color random() => Colors.accents[Random().nextInt(15)];
}

class BarChart {
  static const int barCount = 7;
  List<Bar> bars;

  BarChart(this.bars) {
    assert(bars.length == barCount);
  }

  factory BarChart.empty() {
    return BarChart(List.generate(barCount, (index) => Bar.empty()));
  }

  factory BarChart.random() {
    return BarChart(List.generate(barCount, (index) => Bar.random()));
  }

  static BarChart lerp(BarChart begin, BarChart end, double t) {
    return BarChart(List.generate(barCount, (index) => Bar.lerp(begin.bars[index], end.bars[index], t)));
  }
}
