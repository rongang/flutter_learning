import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning/pages/UI/ui_6.dart';

int syncFibonacci(int n) {
  if (n < 3) return 1;
  List result = List.generate(n, (index) => 1);
  for (int i = 2; i < n; i++) {
    result[i] = result[i - 1] + result[i - 2];
  }
  return result[n - 1];
}

double syncFibonacci2(int n) {
  if (n < 3) return 1;
  Map<int, double> result =
      Map.fromIterables(Iterable<int>.generate(n, (index) => index), List<double>.generate(n, (index) => 1));
  for (int i = 2; i < n; i++) {
    result[i] = result[i - 1]! + result[i - 2]!;
  }
  return result[n - 1]!;
}

class IsolateDemo extends StatefulWidget {
  @override
  _IsolateDemoState createState() => _IsolateDemoState();
}

class _IsolateDemoState extends State<IsolateDemo> {
  TextEditingController _controller = TextEditingController(text: '20');
  double result = 0;
  int timeUse = 0;

  late Timer count;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('计算斐波那契数列'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '结果是：\n$result',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Visibility(visible: result == 0, child: CircularProgressIndicator()),
                ],
              ),
              Text(
                '耗时：$timeUse ms',
                style: Theme.of(context).textTheme.headline5,
              ),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              ),
              DefaultButton(
                title: '开始计算',
                height: 60,
                press: () async {
                  timeUse = 0;
                  result = 0;
                  count = Timer.periodic(Duration(milliseconds: 1), (timer) {
                    timeUse++;
                    setState(() {});
                  });
//                Isolate.spawn((message) { }, 'message');
                  var dateBegin = DateTime.now().millisecondsSinceEpoch;
                  double _result = (await compute<int, double>(syncFibonacci2, int.tryParse(_controller.text)!));
                  count.cancel();
                  timeUse = DateTime.now().millisecondsSinceEpoch - dateBegin;
                  setState(() {
                    result = _result < double.infinity ? _result : -1;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  static Future<int> asyncCountEven(int num) async {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  //这里以计算斐波那契数列为例，返回的值是Future，因为是异步的
  Future<dynamic> asyncFibonacci(int n) async {
    //首先创建一个ReceivePort，为什么要创建这个？
    //因为创建isolate所需的参数，必须要有SendPort，SendPort需要ReceivePort来创建
    final response = new ReceivePort();
    //开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
    //_isolate是创建isolate必须要的参数。
    await Isolate.spawn(_isolate, response.sendPort);
    //获取sendPort来发送数据
    final sendPort = await response.first as SendPort;
    //接收消息的ReceivePort
    final answer = new ReceivePort();
    //发送数据
    sendPort.send([n, answer.sendPort]);
    //获得数据并返回
    return answer.first;
  }

//创建isolate必须要的参数
  void _isolate(SendPort initialReplyTo) {
    final port = new ReceivePort();
    //绑定
    initialReplyTo.send(port.sendPort);
    //监听
    port.listen((message) {
      //获取数据并解析
      final data = message[0] as int;
      final send = message[1] as SendPort;
      //返回结果
      send.send(syncFibonacci(data));
    });
  }
}
