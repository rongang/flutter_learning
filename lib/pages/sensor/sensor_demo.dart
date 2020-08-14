import 'package:flutter/material.dart';
import 'package:flutterdemo/component/action_item.dart';
import 'package:flutterdemo/pages/sensor/sensor_0.dart';
import 'package:flutterdemo/pages/sensor/sensor_1.dart';

class SensorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('地图示例'),
        ),
        body: ListView(
          children: <Widget>[
            ActionItem(title: 'SensorDemo', page: SensorDemo1()),
            ActionItem(title: '摇一摇', page: SensorDemo2()),
          ],
        )
    );
  }
}
