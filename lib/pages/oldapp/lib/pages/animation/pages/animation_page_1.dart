import 'dart:math';

import 'package:flutter/material.dart';

class AnimationPage1 extends StatefulWidget {
  @override
  _AnimationPage1State createState() => _AnimationPage1State();
}

class _AnimationPage1State extends State<AnimationPage1> {
  int num = 100;

  @override
  Widget build(BuildContext context) {
    List value = num.toString().split('');
    return Scaffold(
      appBar: AppBar(
        title: Text('计数器'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 60,
          color: Colors.blue[400],
          child: Row(
            children: <Widget>[
              Counter(
                num: double.tryParse(value[0]),
              ),
              Counter(
                num: double.tryParse(value[1]),
              ),
              Counter(
                num: double.tryParse(value[2]),
              ),
              Counter(
                num: double.tryParse(value[0]),
              ),
              Counter(
                num: double.tryParse(value[1]),
              ),
              Counter(
                num: double.tryParse(value[2]),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shuffle),
        onPressed: () {
          setState(() {
            num = Random().nextInt(999).clamp(100, 999);
          });
        },
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final double num;

  const Counter({Key key, this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 60,
      color: Colors.blue[300],
      child: TweenAnimationBuilder(
        builder: (BuildContext context, value, Widget child) {
          int whole = value ~/ 1;
          double decimal = value - whole;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: -100 * decimal,
                child: Text('$whole',
                    style: Theme.of(context).textTheme.headline3),
              ),
              Positioned(
                top: 100 - 100 * decimal,
                child: Text('$whole',
                    style: Theme.of(context).textTheme.headline3),
              ),
            ],
          );
        },
        tween: Tween(end: num),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
