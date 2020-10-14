import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './Frefresh/Frefreshdemo.dart';
import './Utils/customrotute.dart';

import 'FFloat/ffloatdemo.dart';
class FEIZHUWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('飞猪技术学习'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: RaisedButton(child: Text('FFloat'),onPressed: (){Navigator.push(context, CustomRoute(widget:FFloatDemo()));},),)
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: RaisedButton(child: Text('Frefresh'),onPressed: () => Navigator.push(context, CustomRoute(widget:FRefreshDemo()))),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
