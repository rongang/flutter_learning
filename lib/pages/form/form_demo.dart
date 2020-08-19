import 'package:flutter/material.dart';
import 'package:flutter_learning/component/action_item.dart';
import 'package:flutter_learning/pages/form/profile_edit_demo.dart';

class FormDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('表单输入'),
        ),
        body: ListView(
          children: <Widget>[
            ActionItem(title: '个人信息编辑', page: ProfileEditDemo()),
          ],
        )
    );
  }
}
