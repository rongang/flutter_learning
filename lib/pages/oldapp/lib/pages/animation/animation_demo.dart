import 'package:flutter/material.dart';

import '../../Utils/customrotute.dart';
import 'pages/animation_page_1.dart';
import 'pages/animation_page_2.dart';
import 'pages/animation_page_3.dart';
import 'pages/animation_page_4.dart';

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
      ),
      body: ListView(
        children: <Widget>[
          ActionItem(
            title: '动画一',
            page: AnimationPage1(),
          ),
          ActionItem(
            title: '动画二',
            page: AnimationPage2(),
          ),
          ActionItem(
            title: '动画三',
            page: AnimationPage3(),
          ),
          ActionItem(
            title: '动画四',
            page: AnimationPage4(),
          ),
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String title;
  final Widget page;

  const ActionItem({Key? key, required this.title, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).push(CustomRoute(widget: page));
      },
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
