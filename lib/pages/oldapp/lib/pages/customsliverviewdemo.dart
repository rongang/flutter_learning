import 'package:flutter/material.dart';

class CustomSliverViewDemo extends StatefulWidget {
  @override
  _CustomSliverViewDemoState createState() => _CustomSliverViewDemoState();
}

class _CustomSliverViewDemoState extends State<CustomSliverViewDemo>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 0, vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                    SliverAppBar(
                      forceElevated: innerBoxIsScrolled,
                      stretch: true,
                      pinned: true,
                      floating: true,
                      snap: true,
                      onStretchTrigger: () {
                        // Function callback for stretch
                        print('StretchTrigger');
                        return;
                      },
                      stretchTriggerOffset: 20,
                      expandedHeight: 200.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: const Text('Flight Report'),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                              fit: BoxFit.cover,
                            ),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, 0.5),
                                  end: Alignment(0.0, 0.0),
                                  colors: <Color>[
                                    Color(0x60000000),
                                    Color(0x00000000),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SliverPersistentHeader(
                    delegate: CustomerTabBarDelegate(TabBar(
                      labelColor: Colors.pink,
                  controller: _controller,
                        tabs: <Widget>[
                          Icon(Icons.photo,size: 20,),
                          Icon(Icons.ac_unit),
                          Icon(Icons.fiber_smart_record)
                        ],
                      ),),

                  ),
                  SliverPersistentHeader(
                    delegate: CustomerWidgetDelegate(),
                  ),
//                SliverFixedExtentList(
//                  itemExtent: 100,
//                  delegate: SliverChildBuilderDelegate(
//                      (BuildContext context, int index) {
//                    return ExpansionTile(
//                      initiallyExpanded: false,
//                      title: Text('新闻'),
//                      children: <Widget>[
//                        RichText(
//                            text: TextSpan(
//                                style: TextStyle(color: Colors.black),
//                                text: DateTime.now().toString(),
//                                children: [
//                              TextSpan(text: '疫情'),
//                              TextSpan(
//                                  text: '转变',
//                                  style: TextStyle(
//                                      color: Colors.redAccent,
//                                      fontStyle: FontStyle.italic)),
//                            ]))
//                      ],
//                    );
//                  }, childCount: 10),
//                ),

                  ];

              },
              body: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Icon(Icons.ac_unit,size: 100,),
                  Icon(Icons.fiber_smart_record,size: 100,),
                  Icon(Icons.fiber_smart_record,size: 100,)
                ],
              ),

    ),
          ),
        ),
//        Positioned(
//          bottom: 10,
//          right: 10,
//          child: Container(
//            height: 50,
//            width: 100,
//            decoration: BoxDecoration(
//              color: Colors.indigoAccent,
//              borderRadius: BorderRadius.circular(50),
//              border: Border.all(width: 1, color: Colors.grey),
//              boxShadow: [
//                BoxShadow(
//                    blurRadius: 5.0, //模糊程度
//                    offset: Offset(1.0, 1.0),
//                    spreadRadius: 2 //扩散程度
//                    )
//              ],
//            ),
//          ),
//        ),
      ],
    );
  }
}
class CustomerTabBarDelegate extends SliverPersistentHeaderDelegate{

  final TabBar _tabBar;
  CustomerTabBarDelegate(this._tabBar);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 40,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }


}
class CustomerWidgetDelegate extends SliverPersistentHeaderDelegate{

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 300,
      width: size.width,
      color:Colors.pinkAccent
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 300;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }

}