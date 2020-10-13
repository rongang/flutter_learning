import 'package:flutter/material.dart';
import 'package:flutter_learning/component/action_item.dart';
import 'package:flutter_learning/pages/canvas/canvas_1.dart';
import 'package:flutter_learning/pages/canvas/canvas_2.dart';
import 'package:flutter_learning/pages/canvas/shoping_cart.dart';

import 'keyboard_demo.dart';


class CanvasDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('canvas'),
      ),
      body: ListView(
        children: <Widget>[
          ActionItem(title: '图片裁剪', page: Canvas1()),
          ActionItem(title: '时钟', page: Canvas2()),
          ActionItem(title: '购物车', page: ShoppingCart()),
          ActionItem(title: '打字机效果显示文字', page: KeyBoard()),
        ],
      ),
    );
  }
}
