import 'package:flutter/material.dart';

class AnimationPage2 extends StatefulWidget {
  @override
  _AnimationPage2State createState() => _AnimationPage2State();
}

class _AnimationPage2State extends State<AnimationPage2>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation animation1 = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Interval(0.0, 0.2)))
        .animate(animationController);
    Animation animation2 = Tween(end: 1.0)
        .chain(CurveTween(curve: Interval(0.2, 0.5)))
        .animate(animationController);
    Animation animation3 = Tween(begin: 1.0, end: 0.1)
        .chain(CurveTween(curve: Interval(0.5, 0.9)))
        .animate(animationController);
    return Scaffold(
      appBar: AppBar(
        title: Text('呼吸'),
      ),
      body: Center(
          child: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[500],
                  blurRadius: 60,
                  spreadRadius: 12,
                )
              ],
              shape: BoxShape.circle,
              gradient: RadialGradient(center: Alignment.center, colors: [
                Colors.blue[300],
                Colors.white
              ], stops: [
                animationController.value <= 0.2
                    ? animation1.value
                    : animation3.value,
                1.0
              ]),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.radio_button_unchecked),
        onPressed: () {
          animationController.duration = Duration(seconds: 19);
          animationController.status == AnimationStatus.forward
              ? animationController.stop()
              : animationController.repeat();
        },
      ),
    );
  }
}
