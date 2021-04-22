// import 'package:flutter/material.dart';
//
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// const kAndroidUserAgent =
//     'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';
//
// String selectedUrl = 'https://flutter.io';
//
// // ignore: prefer_collection_literals
// final Set<JavascriptChannel> jsChannels = [
//   JavascriptChannel(
//       name: 'Print',
//       onMessageReceived: (JavascriptMessage message) {
//         print(message.message);
//       }),
// ].toSet();
//
// class CustomWebViewDemo extends StatefulWidget {
//   @override
//   _CustomWebViewDemoState createState() => _CustomWebViewDemoState();
// }
//
// class _CustomWebViewDemoState extends State<CustomWebViewDemo> {
//   final flutterWebViewPlugin = FlutterWebviewPlugin();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: WillPopScope(
//       onWillPop: () async {
//             flutterWebViewPlugin.close();
//         return true;
//       },
//       child: WebviewScaffold(
//         url: "https://www.baidu.com",
//         mediaPlaybackRequiresUserGesture: false,
//         withZoom: true,
//         withLocalStorage: true,
//         hidden: true,
//         javascriptChannels: jsChannels,
//         initialChild: Container(
//           color: Colors.redAccent,
//           child: const Center(
//             child: Text('Waiting.....'),
//           ),
//         ),
//         appBar: AppBar(
//           title: Text("Widget webview"),
//         ),
//       ),
//     ));
//   }
// }
