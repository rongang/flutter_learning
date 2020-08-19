import 'package:flutter/material.dart';

class InteractiveDemo extends StatefulWidget {
  @override
  _InteractiveDemoState createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(300.0),
        minScale: 0.01,
        maxScale: 0.8,
//        constrained: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.orange, Colors.red],
              stops: <double>[0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
