import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class UI4 extends StatefulWidget {
  @override
  _UI4State createState() => _UI4State();
}

class _UI4State extends State<UI4> {
  final _list = ['Home', 'Invoice', 'Notification', 'MyProfile'];
  List<GlobalKey> _listKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];
  int selectedIndex;
  Offset itemOffset;
  double paddingTop;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
    SchedulerBinding.instance.endOfFrame.then((value) {
      getRenderBoxOffset();
    });
  }

  getRenderBoxOffset() {
    RenderBox renderBox =
        _listKeys[selectedIndex].currentContext.findRenderObject();
    Offset widgetOffset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    paddingTop = widgetOffset.dy + size.height / 2;
    print('$widgetOffset======$size');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Container(
              width: 90,
//            color: Colors.green,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.more_horiz),
                        Icon(Icons.search),
                      ]
                        ..addAll(_itemList())
                        ..addAll([
                          Icon(Icons.dashboard),
                        ]),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: 50,
                    top: paddingTop,
//                  bottom: 300,
                    child: CustomPaint(
                      painter: MyIndicator(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        'term 1',
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) => Container(
                              height: 200,
                              width: 100,
                              child: Card(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        'term 2',
                        style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        height: 200,
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) => Container(
                              height: 200,
                              width: 100,
                              child: Card(),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _itemList() => List.generate(
        _list.length,
        (index) => GestureDetector(
          onTap: () {
            if (selectedIndex == index) return;
            selectedIndex = index;

            getRenderBoxOffset();
          },
          child: Container(
            color: Colors.pink,
            child: MyItem(
              title: _list[index],
              isActive: index == selectedIndex,
              globalKey: _listKeys[index],
            ),
          ),
        ),
      );
}

class MyItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final GlobalKey globalKey;

  const MyItem({this.title, this.globalKey, this.isActive});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      key: globalKey,
      quarterTurns: 3,
      child: Text(
        title,
        style: TextStyle(color: isActive ? Colors.white : Colors.black26),
      ),
    );
  }
}

class MyIndicator extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = -math.pi / 2;
    double sweepAngle = math.pi;
    Paint paint = Paint()..style = PaintingStyle.fill;
    paint.color = Colors.pink;
    canvas.drawArc(Rect.fromCircle(center: Offset(10, 0), radius: 30),
        startAngle, sweepAngle, false, paint);
    canvas.drawCircle(
        size.center(Offset(0, 0)), 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
