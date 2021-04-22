// import 'package:flutter/material.dart';
// import 'package:flutter_guidance_plugin/flutter_guidance_plugin.dart';
//
// class GuidanceDemo extends StatefulWidget {
//   @override
//   _GuidanceDemoState createState() => _GuidanceDemoState();
// }
//
// class _GuidanceDemoState extends State<GuidanceDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('步骤引导实例'),
//       ),
//       body: Column(
//         children: <Widget>[
//           ListTile(
//             title: Text('扫描二维码'),
//             trailing: Icon(Icons.camera_enhance),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.whatshot),
//         onPressed: () {
//           showBeginnerGuidance(
//             context,
//             curvePointList: Data.testData,
//             pointX: 0,
//             pointY: 0,
//             isSlide: false,
//             logs: true,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class Data {
//   static List<CurvePoint> testData = List.generate(5, (index) {
//     return CurvePoint(
//       index * 0.1,
//       index * 0.15,
//       tipsMessage: "步骤 $index",
//       nextString: "下一步",
//     );
//   });
// }
