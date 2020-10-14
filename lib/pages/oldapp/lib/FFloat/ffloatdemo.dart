import 'package:ffloat/ffloat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/*
* */
class FFloatDemo extends StatefulWidget {
  @override
  _FFloatDemoState createState() => _FFloatDemoState();
}

class _FFloatDemoState extends State<FFloatDemo> with TickerProviderStateMixin {
  FFloatController _controller1 = FFloatController();
  TabController _tabBarController;

  Widget content() => Text(
        '点击事件',
        style: TextStyle(color: Colors.white),
      );

  Widget demo1() => Center(
        child: FFloat((_) => content(),
            controller: _controller1,
            padding: EdgeInsets.only(left: 9, right: 9, top: 6, bottom: 6),
            corner: FFloatCorner.all(50),
            alignment: FFloatAlignment.topCenter,
            canTouchOutside: true,
            anchor: RaisedButton(
              child: Text(
                '锚点',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                _controller1.show();
              },
            )),
      );

  Widget demo2() => Center(
      child: GestureDetector(
          onPanDown: (offset) {
            FFloat(
              (_) => Text(
                  '${offset.globalPosition.dx.toString().substring(0,3)},${offset.globalPosition.dy.toString().substring(0,3)}'),
//          anchor: ,
              location:
                  Offset(offset.globalPosition.dx, offset.globalPosition.dy),
              alignment: FFloatAlignment.topCenter,
            ).show(context);
          },
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
//            offset: Offset()
                      spreadRadius: 2)
                ]),
            child: null,
          )));

  Widget demo3() => Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.black,
        child: Row(
          children: <Widget>[
            Container(
              child: FFloat(
                (_) => Text('look😁'),
                anchor: Icon(
                  Icons.looks,
                  color: Colors.white,
                ),
                corner: FFloatCorner.all(10),
                padding: EdgeInsets.all(10),
//              cornerStyle: FFloatCornerStyle.bevel,
                alignment: FFloatAlignment.topLeft,
                triangleAlignment: TriangleAlignment.start,
                triangleOffset: Offset(10,0),
                canTouchOutside: true,
              ),
            ),
            Container(
              child: FFloat(
                (_) => Text('add😁'),
                anchor: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                alignment: FFloatAlignment.topCenter,
                canTouchOutside: true,
                padding: EdgeInsets.all(10),
              ),
            ),
            Spacer(),
            Container(
              child: FFloat(
                (_) => SizedBox(
                  height: 60,
                  width: 100,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: TextField(
                          maxLines: 2,
                          scrollPhysics: NeverScrollableScrollPhysics(),
                          minLines: 1,
                          style: TextStyle(fontSize: 20),
                          autofocus: false,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      )
                    ],
                  )
                ),
                anchor: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
//                alignment: FFloatAlignment.topCenter,
//                canTouchOutside: true,
//                margin: EdgeInsets.only(bottom: 10, right: 50),
                alignment: FFloatAlignment.topRight,
                triangleAlignment: TriangleAlignment.end,
                triangleOffset: Offset(-10,0),
                padding: EdgeInsets.all(1),
                corner: FFloatCorner.all(5),
              ),
            ),
          ],
        ),
      ));

  Widget demo4() => Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    child: TextField(
      maxLines: null,
      scrollPhysics: NeverScrollableScrollPhysics(),
      autofocus: false,
      maxLength: 200,
      maxLengthEnforced: false,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.unspecified,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp('[\u4e00-\u9fa5+0-9+a-z]')),
      ],
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent,width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey,width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        labelText: '用户名：',
        focusColor: Colors.pinkAccent,
        fillColor: Colors.yellow,
        hoverColor: Colors.blueAccent
      ),
      style: TextStyle(fontSize: 20),

    ),
  );

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text('FFolat'),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabBarController,
            tabs: <Widget>[
              Text('简单使用'),
              Text('锚点定位'),
              Text('弹出动效'),
              Text('文本框'),
              Text('简单使用'),
            ],
          ),
        ),
        drawer: UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 1.0,
                  offset: Offset(2.0, 2.0),
                  spreadRadius: 2.0)
            ]),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    child: CircleAvatar(
                      maxRadius: 70,
                      backgroundImage: NetworkImage(
                          'http://img.netbian.com/file/2020/0419/7fa12925a4a6cf9df0d6ad253b3bcc98.jpg',
                          scale: 0.1),
                    ),
                  ),
                  ListTile(
                    title: Text('Demo1'),
                    onTap: () {
                      setState(() {
//                    _index = 0;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabBarController,
          children: <Widget>[
            demo1(),
            demo2(),
            demo3(),
            demo4(),
            demo1(),
          ],
        ));
  }
}
