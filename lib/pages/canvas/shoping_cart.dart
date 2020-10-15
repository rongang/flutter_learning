import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/overlay.dart';

const products = ['苹果', '香蕉', '栗子', '石榴', '菠萝', '哈密瓜'];

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final cartGlobalKey = GlobalKey();
  Offset cartOffset;
  Offset productOffset;
  List<OverlayEntry> overlayEntries = [];
  int goodsCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartOffset =
          (cartGlobalKey.currentContext.findRenderObject() as RenderBox)
                  .localToGlobal(Offset.zero) +
              Offset(20, 20);
    });
  }

  showAnimation({Offset start, Offset end}) {
    Offset _offSet =
        Offset(Random().nextDouble() * 100, Random().nextDouble() * 100);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      // return AddToCartAnimation(startOffset: start,endOffset: end,);
      return AddToCartPathAnimation(
        offSet: _offSet,
        startOffset: start,
        endOffset: end,
      );
    });
    overlayEntries.add(overlayEntry);
    MyOverlay.init(overlayEntry: overlayEntry, isShowMul: true);
    Future.delayed(Duration(milliseconds: 500), () {
      if (overlayEntries.isNotEmpty && overlayEntries.length > 0) {
        var entry = overlayEntries.removeAt(0);
        entry?.remove();
        entry = null;
      }
    });
  }

  @override
  void dispose() {
    MyOverlay.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(products[index]),
              trailing: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    setState(() {
                      goodsCount++;
                    });
                    productOffset = (context.findRenderObject() as RenderBox)
                            .localToGlobal(Offset.zero) +
                        Offset(20, 20);
                    print(productOffset);
                    showAnimation(start: productOffset, end: cartOffset);
                    MyOverlay.show();
                    // Future.delayed(Duration(milliseconds: 500), () {
                    //   MyOverlay.cancel();
                    // });
                  },
                ),
              ));
        },
        itemCount: products.length,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ListTile(
          leading: IconButton(
            key: cartGlobalKey,
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 35,
                ),
                Visibility(
                  visible: goodsCount > 0,
                  child: Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                      height: 16,
                      child: Text(
                        '$goodsCount',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                )
              ],
            ),
            onPressed: () {},
          ),
          trailing: Text('结算'),
        ),
      ),
    );
  }
}

class AddToCartPathAnimation extends StatefulWidget {
  const AddToCartPathAnimation({
    Key key,
    @required Offset offSet,
    this.startOffset,
    this.endOffset,
  })  : _offSet = offSet,
        super(key: key);
  final Offset startOffset;
  final Offset endOffset;
  final Offset _offSet;

  @override
  _AddToCartPathAnimationState createState() => _AddToCartPathAnimationState();
}

class _AddToCartPathAnimationState extends State<AddToCartPathAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double left;
  double top;
  double x0, y0, x1, y1, x2, y2;

  @override
  void initState() {
    super.initState();
    left = x0 = widget.startOffset.dx;
    top = y0 = widget.startOffset.dy;
    x1 = widget.endOffset.dx;
    y1 = widget.startOffset.dy +
        (widget.endOffset.dy - widget.startOffset.dy) / 2;
    x2 = widget.endOffset.dx;
    y2 = widget.endOffset.dy;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    controller.addListener(() {
      setState(() {
        calOffset(controller.value);
      });
    });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  calOffset(double t) {
    left = pow(1 - t, 2) * x0 + 2 * t * (1 - t) * x1 + pow(t, 2) * x2;
    top = pow(1 - t, 2) * y0 + 2 * t * (1 - t) * y1 + pow(t, 2) * y2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: top,
            left: left,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ))
      ],
    );
  }
}

class AddToCartAnimation extends StatefulWidget {
  final startOffset;
  final endOffset;

  const AddToCartAnimation({
    Key key,
    this.startOffset,
    this.endOffset,
  }) : super(key: key);

  @override
  _AddToCartAnimationState createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation> {
  Offset nowOffset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomPaint(
        painter: AddToCartPainter(widget.startOffset, widget.endOffset),
      ),
    );
  }
}

class AddToCartPainter extends CustomPainter {
  Offset startOffset;
  Offset endOffset;

  AddToCartPainter(Offset startOffset, Offset endOffset) {
    this.startOffset = startOffset + Offset(20, 20);
    this.endOffset = endOffset + Offset(20, 20);
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawCircle(startOffset, 10, Paint()..color = Colors.redAccent);
    Path p = Path();
    p.moveTo(startOffset.dx, startOffset.dy);
    p.quadraticBezierTo(
        endOffset.dx,
        startOffset.dy + (endOffset.dy - startOffset.dy) / 2,
        endOffset.dx,
        endOffset.dy);
    canvas.drawPath(
        p,
        Paint()
          ..color = Colors.lightBlue
          ..strokeWidth = 10.0
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
