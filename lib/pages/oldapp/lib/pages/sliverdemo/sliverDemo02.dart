import 'package:flutter/material.dart';

class SliverDemo02 extends StatefulWidget {
  @override
  _SliverDemo02State createState() => _SliverDemo02State();
}

class _SliverDemo02State extends State<SliverDemo02> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: FloatHeader(expandHeight: 300, paddingTop: MediaQuery.of(context).padding.top),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              width: size.width,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
//            floating: true,
            delegate: FloatHeader(expandHeight: 100, paddingTop: MediaQuery.of(context).padding.top),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              width: size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class FloatHeader extends SliverPersistentHeaderDelegate {
  final double expandHeight;
  final double paddingTop;
  FloatHeader({required this.expandHeight, required this.paddingTop});

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    print(shrinkOffset);
    return Stack(
      children: <Widget>[
        Container(
          height: maxExtent,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('http://img.netbian.com/file/2020/0712/ccd6fce7874f4f9351ddf67c71ed4536.jpg'),
                  fit: BoxFit.cover)),
          width: size.width,
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            color: this.makeStickyHeaderBgColor(shrinkOffset),
            child: SafeArea(
              bottom: false,
              child: Container(
                height: this.minExtent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: this.makeStickyHeaderTextColor(shrinkOffset, true),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'this.title',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: this.makeStickyHeaderTextColor(shrinkOffset, false),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: this.makeStickyHeaderTextColor(shrinkOffset, true),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandHeight + paddingTop;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw true;
  }
}
