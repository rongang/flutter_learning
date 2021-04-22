import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyBoard extends StatefulWidget {
  @override
  _KeyBoardState createState() => _KeyBoardState();
}

const content =
    '很多时候，我们会有一些奇怪的骚想法，比如让网页中的一些特定文本像敲代码一样一个一个显示出来，有一种命令行的感觉，增加设计感，很多人觉得这个效果要用很长一段JS来实现.... 正好手头有个例子，我决定用Flutter实验一下很多时候，我们会有一些奇怪的骚想法，比如让网页中的一些特定文本像敲代码一样一个一个显示出来，有一种命令行的感觉，增加设计感，很多人觉得这个效果要用很长一段JS来实现.... 正好手头有个例子，我决定用Flutter实验一下';

class _KeyBoardState extends State<KeyBoard> {
  late List<String> cache;
  List<TextSpan> textWidgets = [];
  late Timer timer;
  late int index;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cache = content.split('');
    print(cache);
    init();
  }

  init() {
    index = 0;
    textWidgets.clear();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('打字机效果'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Wrap(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              strutStyle: StrutStyle(
                fontFamily: 'Serif',
                fontSize: 14,
                forceStrutHeight: false,
              ),
              text: TextSpan(
                style: Theme.of(context).textTheme.headline2,
                children: [...textWidgets],
              ),
            ),
            Visibility(
              visible: index > 0,
              child: Cursor(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          init();
          timer = Timer.periodic(
            Duration(milliseconds: 100),
            (timer) {
              if (index >= cache.length) {
                timer.cancel();
                return;
              }
              buildItem();
            },
          );
        },
      ),
    );
  }

  buildItem() {
    setState(() {
      textWidgets.add(TextSpan(text: cache[index++]));
    });
    if (timer.isActive) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 50),
        curve: Curves.linear,
      );
    }
  }
}

class Cursor extends StatefulWidget {
  @override
  _CursorState createState() => _CursorState();
}

class _CursorState extends State<Cursor> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = ColorTween(begin: Colors.white, end: Colors.black).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 5,
      decoration: BoxDecoration(color: animation.value),
    );
  }
}
