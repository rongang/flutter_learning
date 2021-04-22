import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

enum status { one, two, three, four }

const statusMap = {
  status.one: '0',
  status.two: '1',
  status.three: '2',
  status.four: '3',
};

class FlareDemo extends StatefulWidget {
  @override
  _FlareDemoState createState() => _FlareDemoState();
}

class _FlareDemoState extends State<FlareDemo> {
  String animationName = '0';
  status now = status.one;
  status pre = status.one;
  FlareControls _controller = FlareControls();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (position) {
        double pointDx = position.globalPosition.dx;
        double pointDy = position.globalPosition.dy;
        if (pointDy < MediaQuery.of(context).size.height * 0.9) return;
        double onePart = MediaQuery.of(context).size.width / 4.0;
        if (pointDx >= 0 && pointDx <= onePart)
          _changeStatus(status.one);
        else if (pointDx > onePart && pointDx <= onePart * 2)
          _changeStatus(status.two);
        else if (pointDx > onePart * 2 && pointDx <= onePart * 3)
          _changeStatus(status.three);
        else
          _changeStatus(status.four);
      },
      child: FlareActor(
        'assets/images/Nav Bar.flr',
        controller: _controller,
        alignment: Alignment.bottomCenter,
        animation: animationName,
      ),
    );
  }

  _changeAnimationName(status pre, status now) {
//    setState(() {
////      switch (pre) {
////        case status.one:
////          switch (now) {
////            case status.one:
////              break;
////            case status.two:
////              animationName = '0_1';
////              break;
////            case status.three:
////              animationName = '0_2';
////              break;
////            case status.four:
////              animationName = '0_3';
////              break;
////            default:
////              break;
////          }
////          break;
////        case status.two:
////          switch (now) {
////            case status.one:
////              animationName = '1_0';
////              break;
////            case status.two:
////              break;
////            case status.three:
////              animationName = '1_2';
////              break;
////            case status.four:
////              animationName = '1_3';
////              break;
////            default:
////              break;
////          }
////          break;
////        case status.three:
////          switch (now) {
////            case status.one:
////              animationName = '2_0';
////              break;
////            case status.two:
////              animationName = '2_1';
////              break;
////            case status.three:
////              break;
////            case status.four:
////              animationName = '2_3';
////              break;
////            default:
////              break;
////          }
////          break;
////        case status.four:
////          switch (now) {
////            case status.one:
////              animationName = '3_0';
////              break;
////            case status.two:
////              animationName = '3_1';
////              break;
////            case status.three:
////              animationName = '3_2';
////              break;
////            case status.four:
////              break;
////            default:
////              break;
////          }
////          break;
////        default:
////          break;
////      }
//    animationName = statusMap[pre]+"_"+statusMap[now];
//    });
    _controller.play(statusMap[pre]! + "_" + statusMap[now]!);
  }

  _changeStatus(status) {
    if (status == pre) return;
    setState(() {
      _changeAnimationName(pre, status);
      pre = status;
    });
  }
}
