import 'package:flutter/material.dart';
import 'package:flutter_learning/pages/animation/pages/animation_page_4.dart';
import 'package:flutter_learning/pages/animation/pages/animation_page_5.dart';
import 'package:flutter_learning/pages/animation/pages/animation_page_6.dart';
import 'package:flutter_learning/pages/animation/pages/animation_page_7.dart';
import 'package:flutter_learning/pages/flare/flare_demo.dart';
import 'package:flutter_learning/pages/flare/flare_uses.dart';

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
          ActionItem(title: '动画四',page: AnimationPage4(),),
          ActionItem(title: '动画五',page: AnimationPage5(),),
          ActionItem(title: '动画六',page: AnimationPage6(),),
          ActionItem(title: '动画七',page: AnimationPage7(),),
          ActionItem(title: 'Flare动画',page: FlareDemo(),),
          ActionItem(title: 'Flare动画应用',page: FlareUsersPage(),),
        ],
      )
    );
  }
}
