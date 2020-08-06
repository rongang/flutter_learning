import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode nowThemeMode = ThemeMode.light;
  Brightness nowBrightness = Brightness.dark;
  loadThemeMode(ThemeMode themeMode){
    nowThemeMode = themeMode;
    notifyListeners();
  }
  loadBrightness(Brightness brightness){
    this.nowBrightness = brightness;
    notifyListeners();
  }
}