import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final imageUrl =
    'http://img.netbian.com/file/2020/0615/ccec25d9e8fc3ceb4f80c5579447af59.jpg';

class Canvas1 extends StatefulWidget {
  @override
  _Canvas1State createState() => _Canvas1State();
}

class _Canvas1State extends State<Canvas1> with WidgetsBindingObserver {
  ImageClip imageClip;
  double scale = 1.0;
  double preScale = 0.0;
  double startScale;

  Future _future;

  GlobalKey clipAreaKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(NetworkImage(imageUrl), context);
  }

  @override
  void initState() {
    super.initState();
    _future = loadImage();
    WidgetsBinding.instance.addObserver(this);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  handleScale(ScaleUpdateDetails s) {
    // print('$scale');
    if (preScale == 0.0) {
      preScale = scale;
    }
    scale += s.scale - preScale;
    scale = scale.clamp(0.5, 2.0);
    preScale = s.scale;
    setState(() {});
  }

  handleScaleStart(ScaleStartDetails s) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片裁剪'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: _future,
                builder: (context, snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.done:
                      return GestureDetector(
                        onScaleStart: handleScaleStart,
                        onScaleUpdate: handleScale,
                        onScaleEnd: (_) {
                          preScale = 1.0;
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: (_image.height.toDouble()) * 0.23,
                              color: Colors.white,
                            ),
                            Transform.scale(
                              scale: scale,
                              child: Container(
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                            Container(
                              key: clipAreaKey,
                              width: 150,
                              height: 150,
                              child: CustomPaint(
                                painter: ClipArea(),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    default:
                      return CircularProgressIndicator();
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.red,
              height: 200,
              width: 200,
              child: CustomPaint(
                painter: imageClip,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: UniqueKey(),
        child: Column(
          children: [
            Icon(CupertinoIcons.home),
            Icon(CupertinoIcons.home),
          ],
        ),
        onPressed: () {
          double width = _image.width * 0.23;
          double height = _image.height * 0.23;
          RenderBox renderBox = clipAreaKey.currentContext.findRenderObject();
          var size = renderBox.size;
          var begin = renderBox.localToGlobal(Offset.zero) -
              Offset(0, kToolbarHeight + 20);
          print('size--$size--begin--$begin');
          clip(begin.dx / width, begin.dy / height, size.width / 0.23,
              size.height / 0.23);
        },
      ),
    );
  }

  ui.Image _image;

  Future<ui.Image> loadImage() {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageStream imageStream =
        NetworkImage(imageUrl).resolve(ImageConfiguration.empty);
    void listener(ImageInfo image, bool synchronousCall) {
      _image = image.image;
      completer.complete(_image);
      imageStream.removeListener(ImageStreamListener(listener));
    }

    imageStream.addListener(ImageStreamListener(listener));
    return completer.future;
  }

  clip(left, top, width, height) {
    loadImage().then((ui.Image image) {
      imageClip =
          ImageClip(image, left: left, top: top, width: width, height: height);
      setState(() {});
    });
  }
}

class ImageClip extends CustomPainter {
  final ui.Image image;
  final double left, width, height, top;

  ImageClip(this.image,
      {this.left = 0.3,
      this.width = 100.0,
      this.height = 100.0,
      this.top = 0.3});

  @override
  void paint(Canvas canvas, Size size) {
    print('$size');
    //void drawImageRect(Image image, Rect src, Rect dst, Paint paint)
    Paint paint = Paint();
    paint.color = Colors.red;
    double scaleDouble = ((image.width) / (image.height)) * 1.0;
    double widthDouble = size.width * scaleDouble;
    double scaleWidth = size.width / widthDouble;
    canvas.drawImageRect(
        image,
        Rect.fromLTWH(image.width * left, image.height * top, width, height),
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ClipArea extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('$size');
    Paint paint = Paint();
    paint.color = Colors.red;
    // paint.blendMode = BlendMode.srcOut;
    canvas.drawCircle(Offset.zero, 30, paint);
    canvas.save();
    canvas.restore();
    canvas.drawCircle(
        Offset.zero,
        26,
        Paint()
          ..color = Colors.green
          ..blendMode = BlendMode.src);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

