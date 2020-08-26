import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

///双向通信
void main() async {
  await start();
  await Future.delayed(Duration(seconds: 1), () {
    threadPort.send('我来自主线程');
    print('1');
  });
//  await Future.delayed(Duration(seconds: 1), () {
//    threadPort.send('我也来自主线程');
//    print('2');
//  });
//  await Future.delayed(Duration(seconds: 1), () {
//    threadPort.send('end');
//    print('3');
//  });
}
Isolate isolate;

SendPort threadPort;
void start() async {
  var receivePort = ReceivePort();
  isolate = await Isolate.spawn(entryPoint, receivePort.sendPort);
  receivePort.listen((data) {
    if(data is SendPort){
      threadPort = data;
    }
  });
}

//并发isolate
void entryPoint(SendPort sendPort) {
  var receivePort = ReceivePort();
  SendPort newSendPort;
  print('==entryPoint==$sendPort');
  if(sendPort is SendPort){
    newSendPort = sendPort;
    print('子线程开启');
    newSendPort.send(receivePort.sendPort);
    receivePort.listen((data) {
      print('子线程收到来自主线程的消息：$data');
      assert(data is String);
      if(data == 'end'){
        isolate?.kill();
        isolate =null;
        print('子线程结束');
        return;
      }
    });
    return;
  }
}
