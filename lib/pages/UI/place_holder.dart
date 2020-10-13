import 'package:flutter/material.dart';

class PlaceHolder extends StatefulWidget {
  @override
  _PlaceHolderState createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceHolder>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  final _color = Colors.black12;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = ColorTween(begin: Colors.black12, end: Colors.white)
        .animate(controller);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('骨架屏demo'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: animation.value,
              gradient: LinearGradient(
                colors: [Colors.white,animation.value],
                stops: [0.0,controller.value]
              )
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(color: _color),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          height: 15,
                          decoration: BoxDecoration(color: _color),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 10,
                          decoration: BoxDecoration(color: _color),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 150,
                          height: 10,
                          decoration: BoxDecoration(color: _color),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 170,
                          height: 10,
                          decoration: BoxDecoration(color: _color),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
