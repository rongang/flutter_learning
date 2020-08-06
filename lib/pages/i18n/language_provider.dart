import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{
  Locale nowLocale;
  String nowLanguage = '简体中文';
  void loadLanguage(Locale locale){
    nowLocale = locale;
    notifyListeners();
  }
}