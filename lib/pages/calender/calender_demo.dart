import 'package:flutter/material.dart';
import 'package:flutterdemo/component/action_item.dart';
import 'package:flutterdemo/pages/calender/calender_page1.dart';

import 'calender_page2.dart';

class CalenderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('日历插件'),
      ),
      body: ListView(
        children: <Widget>[
          ActionItem(title: '日历1', page: CalenderPage1()),
          ActionItem(title: '日历2', page: CalenderPage2()),
        ],
      ),
    );
  }
}
