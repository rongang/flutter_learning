import 'package:flutter/cupertino.dart';
import 'package:flutter_learning/main.dart';

class MyOverlay {
  static OverlayState overlayState = MyApp.navigatorKey.currentState.overlay;
  static OverlayEntry overlayEntry;
  static bool isShow = false;
  static bool isShowMul;

  MyOverlay() {
    overlayState = MyApp.navigatorKey.currentState.overlay;
  }

  static init({WidgetBuilder widgetBuilder, bool isShowMul,OverlayEntry overlayEntry}) {
    MyOverlay.isShowMul = isShowMul??false;
    // overlayEntry?.remove();
    if(MyOverlay.isShowMul) MyOverlay.overlayEntry = overlayEntry;
    else overlayEntry = OverlayEntry(builder: widgetBuilder);
  }

  static show() {
    if (isShow && !MyOverlay.isShowMul) {
      refresh();
    } else {
      isShow = true;
      overlayState.insert(overlayEntry);
    }
  }

  static refresh() {
    overlayEntry.markNeedsBuild();
  }

  static cancel() {
    if (!isShow) return;
    overlayEntry?.remove();
    // overlayEntry = null;
    isShow = false;
  }
}
