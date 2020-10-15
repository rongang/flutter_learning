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

  static init({
    WidgetBuilder widgetBuilder,
    bool isShowMul = false,
    OverlayEntry overlayEntry,
  }) {
    MyOverlay.isShowMul = isShowMul;
    // overlayEntry?.remove();
    if (isShowMul)
      MyOverlay.overlayEntry = overlayEntry;
    else
      MyOverlay.overlayEntry = OverlayEntry(builder: widgetBuilder);
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
    if (MyOverlay.isShowMul) isShow = false;
    if (!isShow) {
      return;
    }
    overlayEntry?.remove();
    // overlayEntry = null;
    isShow = false;
  }
}
