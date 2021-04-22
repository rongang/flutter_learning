import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

class SplashPageDemo1 extends StatefulWidget {
  @override
  _SplashPageDemo1State createState() => _SplashPageDemo1State();
}

class _SplashPageDemo1State extends State<SplashPageDemo1> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer(Duration(seconds: 3), () {
      route();
    });
    super.initState();
    navigatorTest();
  }

  late OverlayState overlayState;

  navigatorTest() {
    print('${MyApp.navigatorKey.currentState?.overlay?.context}');
    print('${MyApp.navigatorKey.currentContext}');
    print(MyApp.navigatorKey.currentState?.overlay?.context == MyApp.navigatorKey.currentContext);
    overlayState = MyApp.navigatorKey.currentState!.overlay!;
    print(overlayState);
    OverlayEntry overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.redAccent,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      );
    });

    Future(() async {
      // overlayState.insert(overlayEntry);
      // await Future.delayed(Duration(milliseconds: 1000));
      showDialog(
          context: overlayState.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('tip'),
            );
          });
      // showToast();
    });
  }

  Widget get toast => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text("This is a Custom Toast"),
          ],
        ),
      );

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   showToast();
  // }

  showToast() {
    FToast fToast = FToast();
    fToast.init(overlayState.context);
    fToast.showToast(child: toast);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
          duration: Duration(seconds: 3),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (BuildContext context, double value, Widget? child) {
            return Stack(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(),
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                        Colors.pink[900]!,
                        Colors.pink[700]!,
                        Colors.pink[500]!,
                        Colors.pink[300]!,
                        Colors.pink[100]!,
                      ], stops: [
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
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                          ),
                          Text(
                            '跳过',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onTap: () {
                        timer.cancel();
                        route();
                      }),
                )
              ],
            );
          }),
    );
  }

  route() => Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
        (route) => false,
      );
}
