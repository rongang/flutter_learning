import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class Ui2 extends StatefulWidget {
  final Function(String)? onchange;

  const Ui2({Key? key, this.onchange}) : super(key: key);

  @override
  _Ui2State createState() => _Ui2State();
}

class _Ui2State extends State<Ui2> {
  String animationName = 'unfavorite';
  FlareControls _controls = FlareControls();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        child: FlareActor(
          'assets/images/Favorite.flr',
          alignment: Alignment.center,
          animation: animationName,
//          controller: _controls,
        ),
      ),
      onTap: () {
        if (animationName == 'favorite') {
          setState(() {
            animationName = 'unfavorite';
          });
//          _controls.play('unfavorite');
        } else {
          setState(() {
            animationName = 'favorite';
          });
//          _controls.play('Favorite');
        }
        if (widget.onchange != null) {
          widget.onchange!(animationName);
        }
      },
    );
  }
}
