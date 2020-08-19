import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/pages/animation/animation_page.dart';

class ActionItem extends StatelessWidget {
  final String title;
  final Widget page;
  const ActionItem({
    Key key,
    this.title,
    this.page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: (){
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => page));
      },
    );
  }
}