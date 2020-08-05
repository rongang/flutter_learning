import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class Ui2 extends StatefulWidget {
  final Function(String) onchange;

  const Ui2({Key key, this.onchange}) : super(key: key);

  @override
  _Ui2State createState() => _Ui2State();
}

class _Ui2State extends State<Ui2> {
  String animationName = 'Unfavorited';
  FlareControls _controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        child: FlareActor(
          'assets/images/favorite_border_animated.flr',
          alignment: Alignment.center,
            animation: animationName,
          controller: _controls,
        ),
      ),
      onTap: () {
        if (animationName == 'Favorite') {
          setState(() {
            animationName = 'Unfavorited';
          });
//          _controls.play('Unfavorited');
        } else {
          setState(() {
            animationName = 'Favorite';
          });
//          _controls.play('Favorite');
        }
        widget.onchange(animationName);
      },
    );
  }
}
