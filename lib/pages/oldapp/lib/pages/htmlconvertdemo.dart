import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';

import '../Utils/customrouteImage.dart';

const _html = '''<h1 style="color:#FF222222">hello world! 你好世界！</h1>
<img src="http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg" height="200" width="400"><iframe 
src="https://player.bilibili.com/player.html?aid=285789868&bvid=BV1wf4y12753&cid=194414316&page=1" scrolling="no" border="0" frameborder="no" framespacing="1" allowfullscreen="false"width="400"height="200"> </iframe>
<video><source src="https://www.bilibili.com/video/BV1MK411s7Xt/"/></video>''';

class HtmlConvertDemo extends StatefulWidget {
  @override
  _HtmlConvertDemoState createState() => _HtmlConvertDemoState();
}

class _HtmlConvertDemoState extends State<HtmlConvertDemo> {

  /*  void _setJSHandler(InAppWebViewController controller) {
    JavaScriptHandlerCallback callback = (List<dynamic> arguments) async {
      // 解析argument, 获取到高度, 直接设置即可(iphone手机需要+20高度)
      double height = HtmlUtils.getHeight(arguments);
      if (height > 0) {
        setState(() {
          _htmlHeight = height;
        });
      }
    };
    controller.addJavaScriptHandler(HANDLER_NAME, callback);
  }
}*/


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: <Widget>[
          ListTile(title: Icon(Icons.build)),
          Text('===========WebView:'),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                Future.delayed(Duration(milliseconds: 300),
                    () => _showHtml(controller, context));
              },
            ),
          ),
          Text('===========flutter Html:'),
          Html(
            shrinkWrap: true,
            data: _html,
            onImageTap: (src) {
              print(src);
              Navigator.push(context, CustomRouteImage(imageShow(src)));
            },
          )
        ],
      )),
    );
  }

  Widget imageShow(String url) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: GestureDetector(
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        )),
      );

  void _showHtml(WebViewController controller, BuildContext context) async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(_html));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }
}
