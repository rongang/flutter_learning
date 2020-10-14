//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
//const _html = '''<h1 style="color:#FF222222">hello world! 你好世界！</h1>
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="400" width="800">
//<iframe
//src="https://player.bilibili.com/player.html?aid=285789868&bvid=BV1wf4y12753&cid=194414316&page=1" scrolling="no" border="0" frameborder="no" framespacing="1" allowfullscreen="false"width="400"height="200"> </iframe>
//<video><source src="https://www.bilibili.com/video/BV1MK411s7Xt/"/></video>''';
//
//class WebViewMixWidget extends StatefulWidget {
//  @override
//  _WebViewMixWidgetState createState() => _WebViewMixWidgetState();
//}
//
//class _WebViewMixWidgetState extends State<WebViewMixWidget> {
//  InAppWebViewController webView;
//  ContextMenu contextMenu;
//  String url = "";
//  double progress = 0;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('网页组合控件'),
//      ),
//      body: SingleChildScrollView(
//        child: Column(
//          children: <Widget>[
//            ListTile(
//              title: Text('ListTile'),
//            ),
//            Container(
//              height: MediaQuery.of(context).size.height*0.6,
//              margin: const EdgeInsets.all(10.0),
//              decoration:
//              BoxDecoration(border: Border.all(color: Colors.pinkAccent)),
//              child: InAppWebView(
//                  contextMenu: contextMenu,
////                  initialUrl: 'https://www.baidu.com',
//                  // initialFile: "assets/index.html",
//                  initialHeaders: {},
//                  initialOptions: InAppWebViewGroupOptions(
//                      crossPlatform: InAppWebViewOptions(
//                        debuggingEnabled: true,
//                        disableContextMenu: true,
//                      ),
//                      android: AndroidInAppWebViewOptions(
//                          textZoom: 200,
//                          builtInZoomControls: true,
//                          initialScale: 5,
//                          useWideViewPort: true
//                      )),
//                  onWebViewCreated: (InAppWebViewController controller) {
//                    webView = controller;
//                    final String content =
//                    base64Encode(const Utf8Encoder().convert(_html));
//                    controller.loadUrl(url: 'data:text/html;base64,$content');
//                    print("onWebViewCreated");
//                  },
//                  onLoadStart: (InAppWebViewController controller, String url) {
//                    print("onLoadStart $url");
//                    setState(() {
//                      this.url = url;
//                    });
//                  },
//                  onLoadStop:
//                      (InAppWebViewController controller, String url) async {
//                    print("onLoadStop $url");
//                    setState(() {
//                      this.url = url;
//                    });
//                    /*var origins = await WebStorageManager.instance().android.getOrigins();
//                      for (var origin in origins) {
//                        print(origin);
//                        print(await WebStorageManager.instance().android.getQuotaForOrigin(origin: origin.origin));
//                        print(await WebStorageManager.instance().android.getUsageForOrigin(origin: origin.origin));
//                      }
//                      await WebStorageManager.instance().android.deleteAllData();
//                      print("\n\nDELETED\n\n");
//                      origins = await WebStorageManager.instance().android.getOrigins();
//                      for (var origin in origins) {
//                        print(origin);
//                        await WebStorageManager.instance().android.deleteOrigin(origin: origin.origin);
//                      }*/
//                    /*var records = await WebStorageManager.instance().ios.fetchDataRecords(dataTypes: IOSWKWebsiteDataType.ALL);
//                      for(var record in records) {
//                        print(record);
//                      }
//                      await WebStorageManager.instance().ios.removeDataModifiedSince(dataTypes: IOSWKWebsiteDataType.ALL, date: DateTime(0));
//                      print("\n\nDELETED\n\n");
//                      records = await WebStorageManager.instance().ios.fetchDataRecords(dataTypes: IOSWKWebsiteDataType.ALL);
//                      for(var record in records) {
//                        print(record);
//                      }*/
//                  },
//                  onProgressChanged:
//                      (InAppWebViewController controller, int progress) {
//                    setState(() {
//                      this.progress = progress / 100;
//                    });
//                  },
//                  onUpdateVisitedHistory: (InAppWebViewController controller,
//                      String url, bool androidIsReload) {
//                    print("onUpdateVisitedHistory $url");
//                    setState(() {
//                      this.url = url;
//                    });
//                  }),
//            ),
//            Container(
//              height: MediaQuery.of(context).size.height*0.6,
//              margin: const EdgeInsets.all(10.0),
//              decoration:
//              BoxDecoration(border: Border.all(color: Colors.pinkAccent)),
////              child: ,
//            ),
//            ButtonBar(
//              alignment: MainAxisAlignment.center,
//              children: <Widget>[
//                RaisedButton(
//                  child: Icon(Icons.arrow_back),
//                  onPressed: () {
//                    if (webView != null) {
//                      webView.goBack();
//                    }
//                  },
//                ),
//                RaisedButton(
//                  child: Icon(Icons.arrow_forward),
//                  onPressed: () {
//                    if (webView != null) {
//                      webView.goForward();
//                    }
//                  },
//                ),
//                RaisedButton(
//                  child: Icon(Icons.refresh),
//                  onPressed: () {
//                    if (webView != null) {
//                      webView.reload();
//                    }
//                  },
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//      drawer: UnconstrainedBox(
//        child: Container(
//          color: Colors.pinkAccent,
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width / 2,
//          child: Drawer(
//              child: SafeArea(
//            child: Column(
//              children: <Widget>[
//                DrawerHeader(
//                  child: Icon(Icons.person),
//                )
//              ],
//            ),
//          )),
//        ),
//      ),
//    );
//  }
//}
