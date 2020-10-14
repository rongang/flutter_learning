import 'dart:math';

import 'package:flutter/material.dart';

import '../main.dart';

class FutureDemo extends StatefulWidget {
  @override
  _FutureDemoState createState() => _FutureDemoState();
}

class _FutureDemoState extends State<FutureDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureDemo'),
      ),
      body: TweenAnimationBuilder(
        duration: Duration(seconds: 2),
        builder: (BuildContext context, value, Widget child) {
          print(value*10~/1);
          return Opacity(
            opacity: value,
            child: Center(
              child: Container(
                height: 200*value,
                width: 200*value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    colors: [Colors.white,Colors.orangeAccent,],
                    stops: [0.2,1.0],

                  )
                ),
                child: Center(
                  child: FutureBuilder(
                    future: Future.delayed(
                        Duration(seconds: 2), () => DateTime.now()),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return FlatButton(
                          child: Text('sliverDemo'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SliverPage()));
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
        tween: Tween(begin: 0.0,end: 1.0),
      ),
    );
  }
}
