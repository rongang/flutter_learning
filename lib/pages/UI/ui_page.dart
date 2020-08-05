import 'package:flutter/material.dart';
import 'package:flutterdemo/component/action_item.dart';
import 'package:flutterdemo/pages/UI/ui_1.dart';
import 'package:flutterdemo/pages/UI/ui_2.dart';

class UiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI'),
      ),
      body: ListView(
        children: <Widget>[
          ActionItem(title: '展览页', page: UI1()),
          ActionItem(title: '点赞', page: Ui2()),
        ],
      ),
    );
  }
}
