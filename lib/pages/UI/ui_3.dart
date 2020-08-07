import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Ui3 extends StatefulWidget {
  @override
  _Ui3State createState() => _Ui3State();
}

class _Ui3State extends State<Ui3> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double paddingTop = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  upDatePadding(double x) {
    if (x <= 200)
      paddingTop = 0;
    else if (x > 200)
      paddingTop = 300;
    else
      paddingTop = x;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),

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
            duration: Duration(milliseconds: 300),
            top: paddingTop * 0.5,
            left: paddingTop,
            bottom: paddingTop * 0.5,
            child: GestureDetector(
              onHorizontalDragUpdate: (point) {
//                print('${point.delta.distance}');
//                paddingTop = point.globalPosition.dx;
                upDatePadding(point.globalPosition.dx);
//                setState(() {});
              },
//              onHorizontalDragEnd: (point){
//                print('${point.velocity.}');
//              },
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Card(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: CustomScrollView(
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
            ),
          )
        ],
      ),
    );
  }
}
