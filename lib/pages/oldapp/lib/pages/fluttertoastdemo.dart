//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_styled_toast/flutter_styled_toast.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//
//class FlutterToastDemo extends StatefulWidget {
//  @override
//  _FlutterToastDemoState createState() => _FlutterToastDemoState();
//}
//
//class _FlutterToastDemoState extends State<FlutterToastDemo> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('弹窗'),
//        centerTitle: true,
//      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Text('flutter_styled_toast:'),
//          ButtonBar(
//            alignment: MainAxisAlignment.center,
//            children: <Widget>[
//              OutlineButton(
//                child: Text('中间toast'),
//                onPressed: () {
//                  showToast('This is normal toast',
//                      context: context,
//                      textStyle: TextStyle(fontSize: 20.0, color: Colors.red),
//                      backgroundColor: Colors.yellow,
//                      textPadding: EdgeInsets.symmetric(
//                          vertical: 20.0, horizontal: 30.0),
//                      borderRadius: BorderRadius.vertical(
//                          top: Radius.elliptical(10.0, 20.0),
//                          bottom: Radius.elliptical(10.0, 20.0)),
//                      textAlign: TextAlign.justify,
//                      textDirection: TextDirection.rtl);
//                },
//              ),
//            ],
//          ),
//          Text('flutter_flexible_toast'),
//          ButtonBar(
//            alignment: MainAxisAlignment.center,
//            children: <Widget>[
//              OutlineButton(
//                child: Text('下部toast'),
//                onPressed: () {
//                  Fluttertoast.cancel();
//                  SystemChannels.textInput.invokeMethod('TextInput.show');
//                  Fluttertoast.showToast(
//                    gravity: ToastGravity.CENTER,
//                    msg: 'hello worldhello worldhello worldhello worldhello worldhello worldhello world',
//                    backgroundColor: Colors.grey,
//                  );
////                FToast(context).showToast(
////                  child: Text('hello world Color(0xFFD6D6D6)Color(0xFFD6D6D6)Color(0xFFD6D6D6)'),
////                  gravity: ToastGravity.BOTTOM,
////                  toastDuration: Duration(seconds: 10)
////                );
//                },
//              )
//            ],
//          )
//        ],
//      ),
//    );
//  }
//}
