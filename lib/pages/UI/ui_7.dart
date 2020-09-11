// Flutter code sample for GlowingOverscrollIndicator

// This example demonstrates how to use a [NestedScrollView] to manipulate the
// placement of a [GlowingOverscrollIndicator] when building a
// [CustomScrollView]. Drag the scrollable to see the bounds of the overscroll
// indicator.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(SliverGlowingDemo());

/// This Widget is the main application widget.
class SliverGlowingDemo extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatefulWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  // GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // RenderSliverFillRemainingWithScrollable renderBox =
      //     _key.currentContext.findRenderObject();
      // print('${renderBox.getAbsoluteSize()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                // height: 400,
                color: Colors.blueGrey,
              ),
              title: Container(
                color: Colors.orange,
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 56,
                      color: Colors.pinkAccent,
                    ),
                    Text('😊',style: TextStyle(fontSize: kToolbarHeight),),
                    Text('demo')
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(10,100),
              child: Container(),
            ),
            // title: Text('Custom NestedScrollViews'),
          ),
        ];
      },
      body: CustomScrollView(
        shrinkWrap: false,
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: FloatItem(),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.amberAccent,
              height: 100,
              child: Center(child: Text('Glow all day!')),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              // physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.red,
                    height: 300,
                    width: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
          // SliverFillRemaining(key:_key,child: SingleChildScrollView(
          //   physics: ClampingScrollPhysics(),
          //   child: Column(
          //     children: [
          //       Container(color: Colors.red,height: 300,width: 300,),
          //       SizedBox(height: 10,),
          //       Container(color: Colors.red,height: 300,width: 300,),
          //       SizedBox(height: 10,),
          //       Container(color: Colors.red,height: 300,width: 300,),
          //       SizedBox(height: 10,),
          //       Container(color: Colors.red,height: 300,width: 300,),
          //       SizedBox(height: 10,),
          //       Container(color: Colors.red,height: 300,width: 300,),
          //       SizedBox(height: 10,),
          //       Container(color: Colors.red,height: 300,width: 300,),
          //       SizedBox(height: 10,),
          //     ],
          //   ),
          // )),
          // SliverToBoxAdapter(
          //   child: Container(
          //     color: Colors.amberAccent,
          //     height: 100,
          //     child: Center(child: Text('Glow all day!')),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class FloatItem extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.green,
      width: MediaQuery.of(context).size.width,
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
