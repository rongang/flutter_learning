import 'package:flutter/material.dart';

import '../../component/action_item.dart';
import 'pages/animation_page_1.dart';
import 'pages/animation_page_3.dart';
import 'pages/animation_page_2.dart';

class AnimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画示例'),
      ),
      body: ListView(
        children: <Widget>[
          ActionItem(title: '动画一',page: AnimationPage1(),),
          ActionItem(title: '动画二',page: AnimationPage2(),),
          ActionItem(title: '动画三',page: AnimationPage3(),),
        ],
      )
    );
  }
}
