import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class SplashPageDemo1 extends StatefulWidget {
  @override
  _SplashPageDemo1State createState() => _SplashPageDemo1State();
}

class _SplashPageDemo1State extends State<SplashPageDemo1> {

  Timer timer;
  @override
  void initState() {
    timer = Timer(Duration(seconds: 3),(){route();});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
          duration: Duration(seconds: 3),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (BuildContext context, double value, Widget child) {
            return Stack(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue[900],
                            Colors.blue[700],
                            Colors.blue[500],
                            Colors.blue[300],
                            Colors.blue[100],
                          ],
                          stops: [
                            0.0,
                            0.3 * value,
                            0.5 * value,
                            0.7 * value,
                            1 * value
                          ])),
                ),
                Positioned(
                  right: 50,
                  top: 50,
                  child: InkWell(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          value: value,
                        ),
                        Text(
                          '跳过',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onTap: (){
                      timer.cancel();
                      route();
                    }
                  ),
                )
              ],
            );
          }),
    );
  }
  route() => Navigator.of(context).pushAndRemoveUntil(
    CupertinoPageRoute(
        builder: (context) =>
            MyHomePage(title: 'Flutter Demo Home Page')),
        (route) => false,
  );
}
