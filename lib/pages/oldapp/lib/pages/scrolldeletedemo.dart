import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SlideButton extends StatefulWidget {
  Widget child;
  List<Widget> buttons;
  GlobalKey<SlideButtonState> key;
  double singleButtonWidth;

  VoidCallback? onSlideStarted;

  VoidCallback? onSlideCompleted;

  VoidCallback? onSlideCanceled;

  SlideButton(
      {required this.key,
      required this.child,
      required this.singleButtonWidth,
      required this.buttons,
      this.onSlideStarted,
      this.onSlideCompleted,
      this.onSlideCanceled})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SlideButtonState();
  }
}

class SlideButtonState extends State<SlideButton> with TickerProviderStateMixin {
  double translateX = 0;
  late double maxDragDistance;
  final Map<Type, GestureRecognizerFactory> gestures = <Type, GestureRecognizerFactory>{};

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    maxDragDistance = widget.singleButtonWidth * widget.buttons.length;
    gestures[HorizontalDragGestureRecognizer] = GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(debugOwner: this),
      (HorizontalDragGestureRecognizer instance) {
        instance
          ..onDown = onHorizontalDragDown
          ..onUpdate = onHorizontalDragUpdate
          ..onEnd = onHorizontalDragEnd;
      },
    );
    animationController =
        AnimationController(lowerBound: -maxDragDistance, upperBound: 0, vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            translateX = animationController.value;
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.buttons,
            )),
            RawGestureDetector(
              gestures: gestures,
              child: Transform.translate(
                offset: Offset(translateX, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: widget.child,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        onWillPop: () async {
          if (translateX != 0) {
            close();
            return false;
          }
          return true;
        });
  }

  void onHorizontalDragDown(DragDownDetails details) {
    widget.onSlideStarted?.call();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    translateX = (translateX + details.delta.dx).clamp(-maxDragDistance, 0.0);
    setState(() {});
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    animationController.value = translateX;
    if (details.velocity.pixelsPerSecond.dx > 200) {
      close();
    } else if (details.velocity.pixelsPerSecond.dx < -200) {
      open();
    } else {
      if (translateX.abs() > maxDragDistance / 2) {
        open();
      } else {
        close();
      }
    }
  }

  void open() {
    if (translateX != -maxDragDistance)
      animationController.animateTo(-maxDragDistance).then((_) {
        widget.onSlideCompleted?.call();
      });
  }

  void close() {
    if (translateX != 0)
      animationController.animateTo(0).then((_) {
        widget.onSlideCanceled?.call();
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ScrollDeleteDemo extends StatefulWidget {
  @override
  _ScrollDeleteDemoState createState() => _ScrollDeleteDemoState();
}

class _ScrollDeleteDemoState extends State<ScrollDeleteDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('侧滑删除'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SlideButton(
            singleButtonWidth: 100,
            buttons: <Widget>[
              FlatButton(
                child: Text('删除'),
                onPressed: () {
                  print('删除');
                },
              )
            ],
            key: GlobalKey(),
            child: Container(
              color: Colors.green,
              width: double.infinity,
              height: 100,
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  '$index操作',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        },
        itemCount: 3,
      ),
    );
  }
}
