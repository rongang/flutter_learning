import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning/pages/flare/flare_demo.dart';
import '../main.dart';

class PageObserver extends NavigatorObserver {
  @override
  NavigatorState get navigator {
    // print('${navigator.widget.pages}');
    print('${MyApp.navigatorKey.currentState?.overlay?.context}');
    print('${MyApp.navigatorKey.currentContext}');
    // if(MyApp.navigatorKey.currentState == ){
      showDialog(
          context: MyApp.navigatorKey.currentContext,
          child: AlertDialog(
            title: Text('tip'),
          ));
    // }

    // print('${Navigator.of(context)}');
    return super.navigator;
  }

  @override
  void didStopUserGesture() {
    print('-------->didStopUserGesture');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('-------->didStartUserGesture');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('-------->didReplace');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('-------->didRemove');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('-------->didPop');
    print('nowRoute:$route');
    print('preRoute:$previousRoute');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('-------->didPush');
    print('nowRoute:$route');
    print('preRoute:$previousRoute');
  }
}
