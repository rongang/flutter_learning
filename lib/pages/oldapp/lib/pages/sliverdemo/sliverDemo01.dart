import 'package:flutter/material.dart';

class SliverDemo01 extends StatefulWidget {
  @override
  _SliverDemo01State createState() => _SliverDemo01State();
}

class _SliverDemo01State extends State<SliverDemo01> with SingleTickerProviderStateMixin{

  AnimationController animationController;
  Animation animation;
  double expandHeight = 0;
  double beginPosition = 0;
  double downPosition = 0;
  bool isTop = true;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration:Duration(milliseconds: 300));
  }

  startExpand(double positionDy){
    if(beginPosition == 0){
      expandHeight = 0;
//      downPosition = positionDy;
      beginPosition = positionDy;
    }
    expandHeight += positionDy - beginPosition;
    setState(() {
      beginPosition = positionDy;
      expandHeight = expandHeight;
    });
  }


  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
//      print('距离底部 ${notification.metrics.extentAfter}');
      print('距离顶部 ${notification.metrics.extentBefore}');
      //下滑到最底部
      if (notification.metrics.extentAfter == 0.0) {
        print('下滑到最底部');
//        _loadMore();
      }
      setState(() {
        //滑动到最顶部
        if (notification.metrics.extentBefore == 0.0) {
          print('滑动到最顶部');
          isTop = true;
        }else{
          isTop = false;
        }
      });

    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
//        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.black,
            expandedHeight: 380+expandHeight,
            flexibleSpace: FlexibleSpaceBar(
//              title: Container(
//                color: Colors.lightBlue,
//              ),
              background: Listener(
                  onPointerUp: (value){
                    if(downPosition>value.position.dy||!isTop) return;
                    animation = Tween(begin: expandHeight,end: 0.0).animate(animationController)..addListener(() {
                      setState(() {
                        expandHeight = animation.value;
                      });
                    });
                    animationController.forward(from: 0.0);
                    setState(() {
                      beginPosition = 0;
                    });
                  },
                  onPointerMove: (value){
//                    value.transform.ge
                    if(downPosition>value.position.dy) return;
                    startExpand(value.position.dy);
                  },
                  onPointerDown: (value){
                    setState(() {
                      downPosition = value.position.dy;
                    });
                  },
                  child: Header(expandHeight: expandHeight)),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Container(
                alignment: Alignment.center,
                height: 100,
                child: Text('title',style: Theme.of(context).textTheme.headline2,),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 80,
            delegate: SliverChildBuilderDelegate(
                (context,index) => Card(elevation:0,child: ChoiceChip(label: Text('$index'), selected: false,)),childCount: 50
            ),
          )
        ],
      ),
    );
  }
}
class Header extends StatefulWidget {
  final double expandHeight;

  const Header({Key key, this.expandHeight}) : super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200+widget.expandHeight,
                width: size.width,
                child: Image.network('http://img.netbian.com/file/2020/0712/ccd6fce7874f4f9351ddf67c71ed4536.jpg',fit: BoxFit.cover,),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  color: Colors.black,
                ),
              ),
              Divider(height: 1,indent: 10,endIndent: 10,color: Colors.white70,),
              Container(
                height: 100,
                color: Colors.black,
              ),

            ],
          ),
          Positioned(
            top: 150+widget.expandHeight,
            left: 40,
            child: Container(
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage('http://img.netbian.com/file/2020/0601/f6a37767344ab0069f107c73cc125fd3.jpg',),
              ),
            ),
          )
        ],
      ),
    );
  }
}

