import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(SensorDemo2());

class SensorDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 是否已经显示摇一摇弹窗。
  bool isShow = false;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    _streamSubscriptions.add(accelerometerEvents.listen(moveListener));

    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _streamSubscriptions[0].cancel();
  }

  moveListener(AccelerometerEvent event) {
    // 摇一摇阀值,不同手机能达到的最大值不同，如某品牌手机只能达到20。
    int value = 10;
    if (event.x >= value ||
        event.x <= -value ||
        event.y >= value ||
        event.y <= -value ||
        event.z >= value ||
        event.z <= -value) {
      if (!isShow&&context!=null) {
        isShow = true;
        showDialog<bool>(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.3),
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('摇一摇'),
              content: Text('摇啊摇！'),
              actions: [
                CupertinoDialogAction(
                  child: Text('确定'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ).then((onValue) {
          if (onValue != null) {
            // 点击确定后返回的业务逻辑。
          }
          isShow = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('摇一摇'),
      ),
    );
  }
}
