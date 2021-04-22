import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key? key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animationController);
    animation = Tween(begin: 0.0, end: 2.0).animate(animationController);
    //动画正向进行
    // animationController.forward();
    //动画反向进行
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < 100; i++) {
      children.add(Text('11111'));
    }
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: ListView(children: children),
      ),
    );
  }
}
