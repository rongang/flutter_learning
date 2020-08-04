import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeautyUi1 extends StatefulWidget {
  @override
  _BeautyUi1State createState() => _BeautyUi1State();
}

class _BeautyUi1State extends State<BeautyUi1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageViewWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.local_airport), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('')),
        ],
      ),
    );
  }
}

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  final data = [
    'http://img.netbian.com/file/2020/0731/4be42d9f88d1029fb1f4117cd9f22376.jpg',
    'http://img.netbian.com/file/2020/0630/67b49035ce61fcd1af629d7a0e5ea8e8.jpg',
    'http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg'
  ];


  PageController _controller;
  double topPadding = 30;
  double pageOffset = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _controller =  PageController(viewportFraction: 0.8)..addListener(() {
//      print('${_controller.page}');
      setState(() {
        pageOffset = _controller.page;
      });
    });
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      itemCount: 3,
      itemBuilder: (context, index) {
//        if(_controller.page~/1 == index) topPadding = 0;
//        print('${(pageOffset - index).abs()}');
        double scale = max(0.8,1-((pageOffset - index).abs())+0.8);
        double angle = (pageOffset - index).abs();
        if(angle>0.5) angle = 1-angle;
        return Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 300 - scale * 55,
            bottom: 100
          ),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: index == pageOffset~/1?1:0.6,
            child: Transform(
              transform: Matrix4.identity()..setEntry(3,2,0.001)..rotateY(angle),
              alignment: Alignment.center,
              child: Material(
                elevation: 3,
                child: Image.network(
                data[index],
                fit: BoxFit.cover,
        ),
              ),
            ),
          ));
      },
    );
  }
}
