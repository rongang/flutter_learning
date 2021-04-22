import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocalizationDemo {
  final Locale? locale;

  const LocalizationDemo(this.locale);

  static LocalizationDemo _instance = LocalizationDemo(Locale('zh', 'cn'));
  static const supportLanguage = ['en', 'zh'];

  dynamic getItem(String key) {
    Map? data;
    if (locale != null) data = LocalizationInfo[locale?.languageCode];
    if (data == null) return LocalizationInfo['zh']![key];
    return data[key];
  }

  static LocalizationDemo of(BuildContext context) {
    print('localization：${Localizations.of(context, LocalizationDemo)}');
    return Localizations.of<LocalizationDemo>(context, LocalizationDemo) ?? _instance;
  }

  static const LocalizationInfo = {
    'en': {
      'title': 'I18n Demo',
      'content': 'hello world!',
    },
    'zh': {
      'title': 'I18n演示',
      'content': '世界，你好！',
    },
  };

  String get title => getItem('title');

  String get content => getItem('content');
  static const LocalizationDemoDelegate delegate = LocalizationDemoDelegate();
}

class LocalizationDemoDelegate extends LocalizationsDelegate<LocalizationDemo> {
  const LocalizationDemoDelegate();

  @override
  bool isSupported(Locale locale) {
    return LocalizationDemo.supportLanguage.contains(locale.languageCode);
  }

  @override
  Future<LocalizationDemo> load(Locale locale) {
    return SynchronousFuture<LocalizationDemo>(LocalizationDemo(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate old) => false;
}
