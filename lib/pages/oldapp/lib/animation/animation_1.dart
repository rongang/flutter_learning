import 'package:flutter/material.dart';

const String IMAGE =
    'http://img.netbian.com/file/2020/0510/479b031678647c8e69e2a27dbc1d251c.jpg';

class animation_1 extends StatefulWidget {
  final Widget child;

  const animation_1({Key key, this.child}) : super(key: key);
  @override
  _animation_1State createState() => _animation_1State();
}

///需要继承TickerProviderStateMixin 实现多个AnimationController
class _animation_1State extends State<animation_1>
    with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    //默认曲线是线性的 现在添加曲线
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInBack);
    //组件宽高由0.0变为400.0
//    animation = Tween(begin: 0.0, end: 400.0).animate(animationController);
    animationController.forward();
  }

  /*
  * http://img.netbian.com/file/2020/0510/479b031678647c8e69e2a27dbc1d251c.jpg*/
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    //释放动画资源
    animationController.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  final Widget child;
  AnimatedImage({
    Key key,
    this.child,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return SlideTransition(
      position: Tween(begin: Offset(1.0,0.0),end: Offset(0.0,0.0)).animate(animation),
      child: child,
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget widget) {
          return Center(
            child: Container(
                height: MediaQuery.of(context).size.height, width: animation.value, child: widget),
          );
        },
        child: child,
      ),
    );
  }
}

class PAGE extends StatefulWidget {
  @override
  _PAGEState createState() => _PAGEState();
}

class _PAGEState extends State<PAGE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
    );
  }
}
