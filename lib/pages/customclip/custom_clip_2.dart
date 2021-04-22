import 'dart:math';

import 'package:flutter/material.dart';

class CustomClip2 extends StatefulWidget {
  @override
  _CustomClip2State createState() => _CustomClip2State();
}

class _CustomClip2State extends State<CustomClip2> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animation;
  late double indicatorState;
  @override
  void initState() {
    indicatorState = 0.5;
    controller = AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = ColorTween(begin: Color(0xFFFF1744), end: Color(0xFF00BFA5)).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (indicatorState * 100).floor().toString(),
              style: Theme.of(context).textTheme.headline3,
            ),
            TweenAnimationBuilder<double>(
              duration: Duration(seconds: 2),
              tween: Tween(begin: 0.0, end: indicatorState),
              builder: (context, value, child) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: value,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          child: Text('${value * 100 ~/ 1}%'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 20,
                                value: value,
                                valueColor: AlwaysStoppedAnimation<Color>(animation.value!),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          child: Text('${value * 100 ~/ 1}%'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shuffle),
        onPressed: () {
          setState(() {
            indicatorState = Random().nextDouble();
          });
          controller.forward(from: 0.0);
        },
      ),
    );
  }
}
