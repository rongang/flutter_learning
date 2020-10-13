import 'package:flutter/material.dart';
import 'package:flutter_learning/component/action_item.dart';
import 'package:flutter_learning/pages/UI/cupertino_menu_pop.dart';
import 'package:flutter_learning/pages/UI/interactive_demo.dart';
import 'package:flutter_learning/pages/UI/place_holder.dart';
import 'package:flutter_learning/pages/UI/slider_demo.dart';
import 'package:flutter_learning/pages/UI/ui_1.dart';
import 'package:flutter_learning/pages/UI/ui_2.dart';
import 'package:flutter_learning/pages/UI/ui_4.dart';
import 'package:flutter_learning/pages/UI/ui_5.dart';
import 'package:flutter_learning/pages/UI/ui_6.dart';
import 'package:flutter_learning/pages/UI/ui_7.dart';

import 'ui_3.dart';

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
          ActionItem(title: '侧滑个人面板', page: Ui3()),
          ActionItem(title: '自定义tabBar', page: UI4()),
          ActionItem(title: '自定义tabBar', page: Ui5()),
          ActionItem(title: '拖动widget', page: InteractiveDemo()),
          ActionItem(title: '滑动widget', page: SliderDemo()),
          ActionItem(title: 'cupertino弹出菜单', page: CupertinoMenuPopDemo()),
          ActionItem(title: 'app启动页', page: UI6()),
          ActionItem(title: '列表下拉延展', page: SliverGlowingDemo()),
          ActionItem(title: '骨架屏', page: PlaceHolder()),
        ],
      ),
    );
  }
}
