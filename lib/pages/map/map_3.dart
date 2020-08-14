//import 'dart:io' show Platform;
//import 'package:flutter/material.dart';
////import 'package:flutter_bmfmap_example/CustomWidgets/map_appbar.dart';
////import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
////    show BMFMapSDK, BMF_COORD_TYPE;
////import 'flutter_map_demo.dart';
//
//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//
//  // 百度地图sdk初始化鉴权
//  if (Platform.isIOS) {
//    BMFMapSDK.setApiKeyAndCoordType(
//        'yFDD3IlfSk2xTdQ0G41MjRnzd5gUVG1C', BMF_COORD_TYPE.BD09LL);
//  } else if (Platform.isAndroid) {
//    // Android 目前不支持接口设置Apikey,
//    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
//    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
//  }
//
//  runApp(new Map3());
//}
//
//class Map3 extends StatefulWidget {
//
//  @override
//  _Map3State createState() => _Map3State();
//}
//
//class _Map3State extends State<Map3> {
//  @override
//  void initState() {
//    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
////      home: Scaffold(
////          appBar: BMFAppBar(
////            title: '百度地图flutter插件Demo',
////            isBack: false,
////          ),
////          body: FlutterBMFMapDemo()),
//    );
//  }
//}