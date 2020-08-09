import 'package:flutter/material.dart';

class AnimationPage5 extends StatefulWidget {
  @override
  _AnimationPage5State createState() => _AnimationPage5State();
}

class _AnimationPage5State extends State<AnimationPage5>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  double size;
  @override
  void initState() {
    size = 200;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            size = animation.value;
            setState(() {});
          });
    animation = Tween(begin: 200.0,end: 300.0).animate(CurvedAnimation(curve: Curves.bounceOut,parent: _controller));
    _controller.repeat();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画示例五'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.looks_one),
                  onPressed: () {
                    animation = Tween(begin: 200.0,end: 300.0).animate(CurvedAnimation(curve: Curves.bounceOut,parent: _controller));
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.looks_two),
                  onPressed: () {
                    setState(() {
                      animation = Tween(begin: 300.0,end: 400.0).animate(CurvedAnimation(curve: Curves.bounceOut,parent: _controller));
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.looks_3),
                  onPressed: () {
                    animation = Tween(begin: 300.0,end: 200.0).animate(CurvedAnimation(curve: Curves.bounceOut,parent: _controller));
                    setState(() {});
                  },
                ),
              ],
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget child) {
                return Container(
                  color: Colors.blue[300],
                  height: size,
                  width: size,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
