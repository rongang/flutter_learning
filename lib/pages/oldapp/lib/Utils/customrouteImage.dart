import 'package:flutter/cupertino.dart';

class CustomRouteImage extends PageRouteBuilder{
  final Widget child;
  CustomRouteImage(this.child):super(
      transitionDuration:const Duration(milliseconds: 300),
      pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
        return child;
      },
      transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
        return FadeTransition(
          opacity: Tween(begin: 0.0,end: 1.0).animate(animation),
          child: child,
        );
    }

  );
}