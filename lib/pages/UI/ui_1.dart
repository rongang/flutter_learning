import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/pages/UI/ui_2.dart';

class UI1 extends StatefulWidget {
  @override
  _UI1State createState() => _UI1State();
}

class _UI1State extends State<UI1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyPageView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(''),
          ),
        ],
      ),
    );
  }
}

class MyPageView extends StatefulWidget {
  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _controller;
  double pageOffset = 0;
  final images = [
    'http://img.netbian.com/file/2020/0615/ccec25d9e8fc3ceb4f80c5579447af59.jpg',
    'http://img.netbian.com/file/2019/1127/faa3728c8a225f771e19c586e9172ab4.jpg',
    'http://img.netbian.com/file/2019/0527/a4afd9022b9335d9c3240edbf796c04d.jpg'
  ];

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.8)
      ..addListener(() {
        setState(() {
          pageOffset = _controller.page;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: images.length,
      controller: _controller,
      itemBuilder: (context, index) {
        double scale = min(0.8, 1 - (pageOffset - index));
        double angle = pageOffset - index;
        if (angle > 0.5) angle = 1 - angle;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: Hero(
            tag: images[index],
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => DetailsPage(url: images[index])));
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  top: 100 - scale * 25,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DetailsPage extends StatelessWidget {
  final url;

  const DetailsPage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: <Widget>[
                Hero(
                  tag: url,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                Positioned(
                  top: 100,
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        elevation: 0,
        child: Ui2(
          onchange: (status) {
            print('$status');
          },
        ),
        onPressed: null,
      ),
    );
  }
}
