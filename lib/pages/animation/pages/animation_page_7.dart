import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimationPage7 extends StatefulWidget {
  @override
  _AnimationPage7State createState() => _AnimationPage7State();
}

class _AnimationPage7State extends State<AnimationPage7>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  AnimationController _controller;
  BarCharTween tween;
  static const Size size = Size(300,500);

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
//            print('${_controller.value}');
//            print('${tween.evaluate(_controller).bars[0].height}');
            setState(() {});
          });
    tween = BarCharTween(BarChart.empty(), BarChart.random(size,random));
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
      tween = BarCharTween(tween.evaluate(_controller), BarChart.random(size,random));
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
              size: size,
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
  int i;

  @override
  void paint(Canvas canvas, Size size) {
    for (i = 0; i < animation.value.bars.length; i++) {
      Paint p = Paint()
        ..color = animation.value.bars[i].color
        ..style = PaintingStyle.fill;
      canvas.drawRect(
          Rect.fromLTWH(
            animation.value.bars[i].x,
            (size.height - animation.value.bars[i].height), //0
            animation.value.bars[i].width,
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

  double x;

  double width;

  Bar(this.height, this.color, this.x, this.width);

//  factory Bar.random() {
//    return Bar(
//        Random().nextDouble() * 400.0.clamp(20.0, 400.0), RandomColor.random());
//  }

  factory Bar.empty() {
    return Bar(0.0, Colors.transparent, 0, 0.0);
  }

  Bar get collapsed => new Bar.empty();

  static Bar lerp(Bar begin, Bar end, double h) {
    if (begin == null && end == null)
      return null;
    return Bar(
        lerpDouble(begin?.height, end?.height, h),
        Color.lerp((begin??end).color, (end??begin).color, h),
        lerpDouble((begin??end).x, (end??begin).x, h),
        lerpDouble(begin?.width, end?.width, h));
  }
}

class BarTween extends Tween<Bar> {
  BarTween(begin, end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) {
    return Bar.lerp(begin, end, t);
  }
}

class BarCharTween extends Tween<BarChart> {
  BarCharTween(begin, end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) {
    return BarChart.lerp(begin, end, t);
  }
}

class RandomColor {
  static Color random() => Colors.accents[Random().nextInt(15)];
}

class BarChart {
  List<Bar> bars;

  BarChart({this.bars});

  factory BarChart.empty() {
    return BarChart(bars: []);
  }

  factory BarChart.random(Size size, Random random) {
    const barWidthFraction = 0.75;
    const minBarDistance = 20.0;
    final barCount = random.nextInt((size.width / minBarDistance).floor()) + 1;
    final barDistance = size.width / (barCount + 1);
    final barWidth = barDistance * barWidthFraction;
    final startX = barDistance - barWidth / 2;
    final color = RandomColor.random();
    final bars = List.generate(
        barCount,
        (index) => Bar(random.nextDouble() * size.height, color,
            startX + index * barDistance, barWidth));
    return BarChart(bars: bars);
  }

  static BarChart lerp(BarChart begin, BarChart end, double t) {
    final barCount = max(begin.bars.length, end.bars.length);
    return BarChart(
        bars: List.generate(
            barCount,
            (index) => Bar.lerp(
                  begin._barOrNull(index) ,//?? end.bars[index].collapsed,
                  end._barOrNull(index) ,//?? begin.bars[index].collapsed,
                  t,
                )));
  }

  Bar _barOrNull(int index) => (index < bars.length ? bars[index] : null);
}
