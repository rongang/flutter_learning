import 'dart:async';
import 'dart:math' as math;

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class Canvas2 extends StatefulWidget {
  @override
  _Canvas2State createState() => _Canvas2State();
}

class _Canvas2State extends State<Canvas2> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // alignment: Alignment.center,
                height: size.width,
                width: size.width,
                child: Transform.rotate(
                  angle: math.pi * -0.5,
                  child: CustomPaint(
                    painter: ClockPainter(),
                  ),
                ),
              ),
              Text(
                DateUtil.formatDate(DateTime.now(), format: DateFormats.h_m_s),
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  DateTime dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 2, size.height / 2);
    double outRadius = size.width / 2 - 30;
    double innerRadius = outRadius - 30;
    canvas.drawCircle(offset, outRadius - 50, Paint()..color = Colors.black26);

    for (int i = 0; i < 360; i += 6) {
      double x1 = offset.dx + math.cos(i * math.pi / 180) * outRadius;
      double y1 = offset.dx + math.sin(i * math.pi / 180) * outRadius;
      double x2 = offset.dx + math.cos(i * math.pi / 180) * innerRadius;
      double y2 = offset.dx + math.sin(i * math.pi / 180) * innerRadius;
      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = Colors.black26
            ..strokeWidth = 5
            ..strokeCap = StrokeCap.round);
    }
    for (int i = 0; i < dateTime.second * 6; i += 6) {
      double x1 = offset.dx + math.cos(i * math.pi / 180) * outRadius;
      double y1 = offset.dx + math.sin(i * math.pi / 180) * outRadius;
      double x2 = offset.dx + math.cos(i * math.pi / 180) * innerRadius;
      double y2 = offset.dx + math.sin(i * math.pi / 180) * innerRadius;
      canvas.drawLine(
          Offset(x1, y1),
          Offset(x2, y2),
          Paint()
            ..color = Colors.blue
            ..strokeWidth = 5
            ..strokeCap = StrokeCap.round);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
