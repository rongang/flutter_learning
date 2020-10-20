import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/overlay.dart';
import 'package:flutter_learning/utils/utils.dart';

class GuideDemo extends StatefulWidget {
  @override
  _GuideDemoState createState() => _GuideDemoState();
}

class _GuideDemoState extends State<GuideDemo> {
  final buttonGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    MyOverlay.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('页面引导'),
      ),
      body: Center(
        child: OutlinedButton(
          clipBehavior: Clip.antiAlias,
          key: buttonGlobalKey,
          child: Text('显示引导'),
          onPressed: () {
            print(kIsWeb);
            // if(Platform.isFuchsia)
            if(kIsWeb){
              Utils.showDiglogg(content: '暂不支持web平台');
              return;
            }
            buildGuide();
            MyOverlay.show();
          },
        ),
      ),
    );
  }

  static const itemInfo = [
    Size(23.0, 40.0),
    Size(10.0, 10.0),
    Size(20.0, 20.0),
    Size(30.0, 30.0),
    Size(40.0, 40.0),
  ];
  Size size;
  Offset offset;

  void buildGuide() {
    RenderBox renderBox = buttonGlobalKey.currentContext.findRenderObject();
    offset = renderBox.localToGlobal(Offset.zero);
    size = renderBox.size; //itemInfo[Random().nextInt(5)];
    MyOverlay.init(widgetBuilder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body:
        // Container(
        //   alignment: Alignment.center,
        //   constraints: BoxConstraints.expand(),
        //   decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.4),
        //       backgroundBlendMode: BlendMode.src),
        //   child: Container(
        //     height: 200,
        //     width: 200,
        //     decoration: BoxDecoration(
        //       color: Colors.redAccent,
        //       backgroundBlendMode: BlendMode.clear
        //     ),
        //   ),
        // ),
        Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(.4),
                BlendMode.srcOut,
              ),
              child: Container(
                // color: Colors.lightBlue,
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  backgroundBlendMode: BlendMode.dst,
                ),
                child: Stack(
                  children: [
                    GuideItem(
                      // key: ValueKey(size),
                      offset: offset,
                      size: size,
                    ),
                    Center(
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            setState(() {
                              size = itemInfo[Random().nextInt(5)];
                              offset = Offset(Random().nextDouble() * 200,
                                  Random().nextDouble() * 400);
                            });
                            MyOverlay.show();
                          },
                          child: Text('下一步')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Text(
            '跳过',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            MyOverlay.cancel();
          },
        ),
      );
    });
  }
}

class GuideItem extends StatelessWidget {
  static final time = Duration(milliseconds: 300);
  final Offset offset;
  final Size size;

  const GuideItem({
    Key key,
    this.offset,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: offset.dy,
      left: offset.dx - 5.0,
      child: AnimatedContainer(
        width: size.width + 10.0,
        height: size.height,
        duration: time,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
            backgroundBlendMode: BlendMode.srcOut),
      ),
      duration: time,
    );
  }
}
