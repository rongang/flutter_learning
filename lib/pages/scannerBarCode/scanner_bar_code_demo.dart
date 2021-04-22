// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qrscan/qrscan.dart' as Scanner;
//
// class ScannerBarCodeDemo extends StatefulWidget {
//   @override
//   _ScannerBarCodeDemoState createState() => _ScannerBarCodeDemoState();
// }
//
// class _ScannerBarCodeDemoState extends State<ScannerBarCodeDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: RaisedButton(
//           child: Text('扫码'),
//           onPressed: () async {
//             if(Platform.isAndroid){
//             String barCode;
//             try{
//               barCode = await Scanner.scan();
//             }on PlatformException catch (e){
//               print(e.toString()+'扫码错误');
//             }
//
//             if (barCode == null || barCode.length <= 0) {
//               print('未能识别二维码');
//               return;
//             }}else if(Platform.isIOS){
//
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
