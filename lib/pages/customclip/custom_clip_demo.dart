import 'package:flutter/material.dart';
import 'package:flutter_learning/component/action_item.dart';
import 'package:flutter_learning/pages/customclip/custom_clip_2.dart';
import 'custom_clip_1.dart';

class CustomClipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('自定义裁剪示例'),
        ),
        body: ListView(
          children: <Widget>[
            ActionItem(title: '裁切图形', page: CustomClip1()),
            ActionItem(title: '裁切进度条', page: CustomClip2()),
          ],
        )
    );
  }
}
