import 'package:flutter/material.dart';
import 'package:flutter_learning/component/action_item.dart';
import 'package:flutter_learning/pages/map/map_1.dart';

class MapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('地图示例'),
        ),
        body: ListView(
          children: <Widget>[
            ActionItem(
              title: '地图一',
              page: Map1(),
            ),
            // ActionItem(title: '地图二',page: Map2(),),
          ],
        ));
  }
}
