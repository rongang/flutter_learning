// import 'dart:async';
// import 'package:quill_delta/quill_delta.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:zefyr_plus/zefyr.dart';
// class RichTextDemo extends StatefulWidget {
//   @override
//   _RichTextDemoState createState() => _RichTextDemoState();
// }
//
// const content = '<p class="remind" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; width: 550px; float: left;">ommon-fileupload.jar 包存在 ddos 漏洞，请尽快升级到最新的版本，直达链接：<a href="https://commons.apache.org/proper/commons-fileupload/" style="text-decoration-line: none; outline: none;">Apache fileupload jar</a></p> <p class="remind" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; width: 550px; float: left;">UEditor 所提供的所有后端代码都仅为 DEMO 作用，<strong>切不可直接使用到生产环境中</strong>，目前已知 php 的代码会存在 ssrf 的安全漏洞。修复方式：使用最新的 Uploader&nbsp;<a href="https://github.com/fex-team/ueditor/blob/dev-1.5.0/php/Uploader.class.php" style="text-decoration-line: none; outline: none;">https://github.com/fex-team/ueditor/blob/dev-1.5.0/php/Uploader.class.php</a></p> <p class="remind" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; width: 550px; float: left;">因该问题导致的安全漏洞，与产品本身无关。</p> <p class="note" style="margin-right: 5px; margin-left: 5px; padding: 0px; color: red; font-family: Tahoma, Helvetica, &quot;Microsoft Yahei&quot;, 微软雅黑, Arial, STHeiti; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);"> <span class="remind" style="width: 550px; float: left;">注：线上演示版上传功能只作为功能演示，1.4.3以上版本将不再承诺支持ie6/ie7。</span></p> <p><br/></p>';
//
// class _RichTextDemoState extends State<RichTextDemo> {
//   final Completer<WebViewController> _controller =
//   Completer<WebViewController>();
//   Future<WebViewController> webViewControllerFuture;
//
//   final TextEditingController _TextEditingController = new TextEditingController();
//   final ZefyrController _zefyrController = new ZefyrController(NotusDocument());
//   final FocusNode _focusNode = new FocusNode();
//   String _title = "";
//   var _delta;
//   var json;
//   String string;
//   var plainText;
//
// //  Widget _body()=>SingleChildScrollView(
// //    child: WebView(
// //      initialUrl: 'https://flutter.dev',
// //      javascriptMode: JavascriptMode.unrestricted,
// //      onWebViewCreated: (WebViewController webViewController) {
// //        _controller.complete(webViewController);
// //        webViewControllerFuture = _controller.future;
// //      },)
// //  );
//   Widget _body()=>SingleChildScrollView(
//     child: ZefyrScaffold(
//       child: Column(
//         children: <Widget>[
//           _descriptionEditor(),
//         ],
//           ),
//     )
//   );
//   Widget _descriptionEditor() {
//     final theme = new ZefyrThemeData(
//       toolbarTheme: ToolbarTheme.fallback(context).copyWith(
//         color: Colors.grey.shade800,
//         toggleColor: Colors.grey.shade900,
//         iconColor: Colors.white,
//         disabledIconColor: Colors.grey.shade500,
//       ),
//     );
//
//     return ZefyrTheme(
//       data: theme,
//       child: ZefyrField(
//         height: 400.0,
//         decoration: InputDecoration(labelText: 'Description'),
//         controller: _zefyrController,
//         focusNode: _focusNode,
//         autofocus: true,
//         physics: ClampingScrollPhysics(),
//       ),
//     );
//   }
//   @override
//   void initState() {
//     _zefyrController.document.changes.listen((change) {
//       setState(() {
//         //获取数据的方式有一些
//         _delta = _zefyrController.document.toDelta();
//         json = _zefyrController.document.toJson();
//         string = _zefyrController.document.toString();
//         plainText = _zefyrController.document.toPlainText();
//       });
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RichText'),
//       ),
//       body: Container(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child:
//           Theme.of(context).platform == TargetPlatform.iOS
//               ? CupertinoScrollbar(
//             child: _body(),
//           )
//               : Scrollbar(
//             child: _body(),
//           )),
//     );
//
//   }
// }
//
