import 'dart:ui' as ui;

class ScreenUtil {
  static int width = 720;
  static int height = 1280;
  static double dpr = 1.0;

  static init({int width, int height, double dpr}) {
    ScreenUtil.width = width;
    ScreenUtil.height = height;
    ScreenUtil.dpr = dpr;
  }

  static var _screenWidth = ui.window.physicalSize.width / ScreenUtil.dpr;
  static var _screenHeight = ui.window.physicalSize.height / ScreenUtil.dpr;

  static get screenWidth => _screenWidth;

  static get screenHeight => _screenHeight;

  static get scaleW => screenWidth / width;

  static get scaleH => screenHeight / height;

  static getFlexWidth(double width) {
    return width * scaleW;
  }

  static getFlexHeight(double height) {
    return height * scaleH;
  }
}
