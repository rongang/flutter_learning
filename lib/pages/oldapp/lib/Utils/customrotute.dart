import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget widget;

  CustomRoute({this.widget, RouteSettings settings})
      : super(
            settings: settings,
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (
              BuildContext context,
              Animation<double> animationBegin,
              Animation<double> animationEnd,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animationBegin,
              Animation<double> animationEnd,
              Widget child,
            ) {
              return SlideTransition(
                  position: Tween(
                    begin: Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animationBegin),
                  child: FadeTransition(
                    opacity:Tween(begin: 0.3,end: 1.0).animate(animationBegin),
                    child: child,
                  ));
            });
}
