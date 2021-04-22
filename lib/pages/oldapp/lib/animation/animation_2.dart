import 'package:flutter/material.dart';

const String IMAGE = 'http://img.netbian.com/file/2020/0319/smallbd660668c58757db095539ffe7962af01584626514.jpg';

class animation_2 extends StatefulWidget {
  @override
  _animation_2State createState() => _animation_2State();
}

//需要继承TickerProviderStateMixin 实现多个AnimationController
class _animation_2State extends State<animation_2> with TickerProviderStateMixin {
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
    curvedAnimation = CurvedAnimation(curve: Curves.bounceIn, parent: animationController);
    animation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);
    //动画正向进行
    // animationController.forward();
    //动画反向进行
    animationController.repeat();
  }

  @override
  void dispose() {
    //一定要记住销毁动画
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('动画二'),
        ),
        body: AnimatedImage(
          animation: animation,
        ));
  }
}

//如果有多个动画，为了减少重复工作 可以使用AnimationWidget来帮我们完成动画的初始化操作
class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key? key, required Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: SizeTransition(
        sizeFactor: animation,
        child: Image.network(IMAGE),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key? key, required this.child, required this.animation}) : super(key: key);
  final Animation animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: Image.network(IMAGE),
      builder: (BuildContext ctx, Widget? child) {
        return Center(
          child: Container(
            child: child,
            height: animation.value,
            width: animation.value,
          ),
        );
      },
    );
  }
}
