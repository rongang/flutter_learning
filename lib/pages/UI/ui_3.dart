import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Ui3 extends StatefulWidget {
  @override
  _Ui3State createState() => _Ui3State();
}

class _Ui3State extends State<Ui3> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double paddingTop = 0.0;
  double width;
  double beginPoint;
  double temp = 0;
  bool isOpen = false;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  upDatePadding() {
    if (paddingTop <= 100){
      isOpen = false;
      paddingTop = 0;
    }
    else if (paddingTop > 100){
      isOpen = true;
      paddingTop = width;
      temp = paddingTop;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width/2;
    return Listener(
      onPointerMove: (point){
        double dx = point.position.dx - beginPoint;
        if(dx>10&&!isOpen) paddingTop = dx;
        else if(dx<0&&isOpen) {
          paddingTop = temp + dx;
        }
        setState(() {});
      },
      onPointerDown: (point){
        beginPoint = point.position.dx;
      },
      onPointerUp: (point){
        upDatePadding();
      },
      child: Scaffold(
        backgroundColor: Colors.blue[300],
        body: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              right: width - paddingTop,
              left: - (width - paddingTop),
              top: 0,
              bottom: 0,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://dss0.bdstatic.com/6Ox1bjeh1BF3odCf/it/u=1681661696,3228509594&fm=85&app=92&f=PNG?w=121&h=75&s=7D904B958C416EC809BDD9DE0300C031'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('hello world'),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: Text(
                        'share',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: Text(
                        'share',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: Text(
                        'share',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: Text(
                        'share',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      child: Text(
                        'share',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 100),
              top: paddingTop * 0.5,
              left: paddingTop,
              bottom: paddingTop * 0.5,
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                duration: Duration(milliseconds: 100),
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        elevation: 0,
                        expandedHeight: 300.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                            'http://img.netbian.com/file/2020/0630/67b49035ce61fcd1af629d7a0e5ea8e8.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
