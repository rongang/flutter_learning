import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterdemo/pages/i18n/language_provider.dart';
import 'package:provider/provider.dart';

class I18nDemo {
  Locale locale;

  I18nDemo(this.locale);

  static I18nDemo instance = I18nDemo(Locale('zh', 'cn'));
  static const I18nDemoDelegate delegate = I18nDemoDelegate();

  static const supportLanguage = ['en', 'zh'];
  static const supportLanguageIterable = [
    const Locale('en', 'US'),
    const Locale('zh', 'CN')
  ];
  static const data = {
    'en': {
      'title': 'I18n demo',
      'content': 'hello world!',
      'language1': 'chinese',
      'language2': 'english',
    },
    'zh': {
      'title': '国际化演示',
      'content': '你好，世界！',
      'language1':'简体中文',
      'language2':'英文',
    }
  };

  dynamic getItem(String key) {
    Map d;
    d = data[locale.languageCode];
    if (d == null) d = data['zh'];
    return d[key];
  }

  get title => getItem('title');

  get content => getItem('content');

  static I18nDemo of(BuildContext context) {
//    locale = Provider.of<LanguageProvider>(context).nowLanguage;
    return Localizations.of(context, I18nDemo) ?? instance;
  }
}

class I18nDemoDelegate extends LocalizationsDelegate<I18nDemo> {
  const I18nDemoDelegate();

  @override
  bool isSupported(Locale locale) {
    return I18nDemo.supportLanguage.contains(locale.languageCode);
  }

  @override
  Future<I18nDemo> load(Locale locale) {
    return SynchronousFuture<I18nDemo>(I18nDemo(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<I18nDemo> old) => false;
}
