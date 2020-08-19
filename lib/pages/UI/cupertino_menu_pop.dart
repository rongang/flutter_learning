import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoMenuPopDemo extends StatefulWidget {
  @override
  _CupertinoMenuPopDemoState createState() => _CupertinoMenuPopDemoState();
}

class _CupertinoMenuPopDemoState extends State<CupertinoMenuPopDemo> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('弹窗展示'),
        previousPageTitle: 'previous',
//        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              color: Colors.grey[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text('cupertino菜单'),
              onPressed: () {
                showCupertinoModalPopup(
                  filter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      cancelButton: FlatButton(
                        child: Text('取消',style: TextStyle(color: Colors.pink),),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      title: Text('删除该联系人'),
                      message: Text('永久删除'),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {  },
                          child: Text('删除'),
                        ),
                      ],
                    );
                  },
                  context: context,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
