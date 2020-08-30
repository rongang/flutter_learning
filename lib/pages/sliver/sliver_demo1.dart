import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_learning/pages/flare/flare_demo.dart';

class SliverDemo1 extends StatefulWidget {
  @override
  _SliverDemo1State createState() => _SliverDemo1State();
}

class _SliverDemo1State extends State<SliverDemo1> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  double loadIndicatorHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
//      body: Container(
//        alignment: Alignment.bottomCenter,
//        child: FlareActor('assets/images/Nav Bar.flr'),
//      ),
          body: RefreshIndicator(
            onRefresh: () async {
             await  Future.delayed(Duration(seconds: 1));
            },
            child: NotificationListener(
              onNotification: (ScrollNotification notification) {
//                print('${_scrollController.position.userScrollDirection}');
                if (_scrollController.position.userScrollDirection ==
                    ScrollDirection.reverse) {
//                  print('${_scrollController.position.pixels}');
//                  print('${_scrollController.position.maxScrollExtent}');
                  double offSetScrollDy = _scrollController.position.pixels -
                      _scrollController.position.maxScrollExtent;
                  if (offSetScrollDy > 0) {
                    setState(() {
                      loadIndicatorHeight = offSetScrollDy;
                    });
                      if (loadIndicatorHeight > 60) {
                        if(!isLoading)
                          isLoading = true;
                          Future.delayed(Duration(milliseconds: 2000), () {
                            print('loading compete');
                        setState(() {
                              isLoading = false;
                            });
                          });
                      }
                  }
//                  if (_scrollController.position.maxScrollExtent - 50 <
//                      notification.metrics.pixels) {
//                    if (!isLoading) {
//                      setState(() {
//                        isLoading = true;
//
//                      });
//                    }
//                    print('加载更多');
//                  }
                }
                return false;
              },
              child: CustomScrollView(
                controller: _scrollController,
//            physics: ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: AppHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 500,
                      color: Colors.blue[100],
                    ),
                  ),
                  // Sliver
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        height: 500,
                        color: Colors.blue[300],
                      );
                    }, childCount: 1),
                  )
                ],
              ),
            ),
          ),
//      bottomNavigationBar: BottomAppBar(
//        color: Colors.transparent,
//        child: Container(
//          color: Colors.transparent,
//          height: 100,
//          child: FlareDemo(),
//        ),
//      ),
        ),
        Visibility(
          visible: isLoading,
          child: AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              bottom: loadIndicatorHeight - 50,
              child: RefreshProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              )),
        )
      ],
    );
  }
}

class AppHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: maxExtent,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            'http://img.netbian.com/file/2020/0615/ccec25d9e8fc3ceb4f80c5579447af59.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: (160 - shrinkOffset),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
            decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
