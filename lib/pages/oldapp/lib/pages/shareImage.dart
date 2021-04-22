import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class ShareImageDemo extends StatefulWidget {
  ShareImageDemo({Key? key}) : super(key: key);

  @override
  _ShareImageDemoState createState() => _ShareImageDemoState();
}

GlobalKey repaintWidgetKey = GlobalKey(); // 绘图key值

class _ShareImageDemoState extends State<ShareImageDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('截图分享'),
        ),
        body: Column(
          children: <Widget>[
            RepaintBoundary(
              key: repaintWidgetKey,
              child: Container(
                height: 500,
                width: 400,
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    color: Colors.redAccent,
                    child: Text(
                      'hello world',
                      style: TextStyle(color: Colors.white, fontSize: 80),
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                print('截图分享');
                _shareUiImage(context);
              },
              child: Text('截图分享'),
            ),
          ],
        ));
  }

  /// 把图片ByteData写入File，并触发微信分享
  Future<Null> _shareUiImage(BuildContext context) async {
    ByteData sourceByteData = (await _capturePngToByteData())!;
    Uint8List sourceBytes = sourceByteData.buffer.asUint8List();
//    Navigator.push(context, CustomRouteImage(imageView(sourceBytes,context)));
    imageView(sourceBytes, context);
    Directory tempDir = await getTemporaryDirectory();

    String storagePath = tempDir.path;
    File file = new File('$storagePath/报告截图.png');

    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);
  }

  /// 截屏图片生成图片流ByteData
  Future<ByteData?> _capturePngToByteData() async {
    try {
      RenderRepaintBoundary boundary = repaintWidgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      double dpr = ui.window.devicePixelRatio; ////
      boundary.computeMaxIntrinsicHeight(20);
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData _byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
      return _byteData;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void imageView(Uint8List bytes, BuildContext context) => showModalBottomSheet(
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  child: Center(
                    child: Container(
                      height: 300,
                      width: 200,
                      child: Image.memory(
                        bytes,
                        scale: 1,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.transparent, border: Border.all(width: 1, color: Colors.black)),
                ),
                Container(
//            height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          print('微信分享');
                        },
                        icon: Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.favorite_border),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.add_alert),
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
      context: context);
}
