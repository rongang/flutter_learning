import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterdemo/pages/UI/ui_page.dart';
import 'package:flutterdemo/pages/animation/animation_page.dart';
import 'package:flutterdemo/pages/i18n/i18n_demo.dart';
import 'package:flutterdemo/pages/i18n/language_provider.dart';
import 'package:flutterdemo/pages/map/map_demo.dart';
import 'package:flutterdemo/pages/scannerBarCode/scanner_bar_code_demo.dart';
import 'package:flutterdemo/pages/sliver/sliver_demo1.dart';
import 'package:flutterdemo/pages/splashPage/splashPageDemo1.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'component/action_item.dart';
import 'pages/UI/ui_1.dart';
import 'pages/calender/calender_demo.dart';
import 'pages/i18n/i18n_page.dart';
import 'pages/medirec/medirec.dart';
import 'pages/sensor/sensor_demo.dart';
import 'pages/theme/theme_provider.dart';

void main() {
//  androidHeadInit();
  runApp(MyApp());
}

androidHeadInit() {
  if (Platform.isAndroid) {
    // 设置 Android 头部导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      builder: (context, child) {
        LanguageProvider languageProvider = context.watch<LanguageProvider>();
//              Provider.of<LanguageProvider>(context);
        ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
        Brightness _brightness =
            context.select((ThemeProvider provider) => provider.nowBrightness);
        return MaterialApp(
          themeMode: themeProvider.nowThemeMode,
          // themeProvider.nowThemeMode,
          locale: languageProvider.nowLocale,
          supportedLocales: I18nDemo.supportLanguageIterable,
          localizationsDelegates: [
            I18nDemo.delegate
          ]..addAll(GlobalMaterialLocalizations.delegates),
//          localeListResolutionCallback:
//              (List<Locale> locales, Iterable<Locale> supportedLocales) {
//            print('locale:${locales.toString()}');
//            print('support:${supportedLocales.toString()}');
//            bool hasZH = false;
//            locales.forEach((e) {
//              if (e.languageCode == 'zh') hasZH = true;
//            });
//            if (hasZH) {
//              languageProvider.nowLocale = Locale('zh', 'CN');
//              return Locale('zh', 'CN');
//            }
//            languageProvider.nowLocale = locales[0];
//            return locales[0];
//          },
//      localeResolutionCallback: (locale,support){
//        print('locale:$locale');
//        print('support:${support.toString()}');
//        return locale;
//      },
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: _brightness,
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
              // This makes the visual density adapt to the platform that you run
              // the app on. For desktop platforms, the controls will be smaller and
              // closer together (more dense) than on mobile platforms.
              visualDensity: VisualDensity.adaptivePlatformDensity,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  foregroundColor:
                      themeProvider.nowBrightness == Brightness.light
                          ? Colors.blue[300]
                          : Colors.black)),
          home: SplashPageDemo1(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ActionItem(title: '动画', page: AnimationPage()),
          ActionItem(title: 'UI', page: UiPage()),
          ActionItem(title: 'Sliver', page: SliverDemo1()),
          ActionItem(title: 'I18nPage', page: I18nPage()),
          ActionItem(title: '日历', page: CalenderDemo()),
          ActionItem(title: '吃药啦', page: Medirec()),
          ActionItem(title: '扫码', page: ScannerBarCodeDemo()),
          ActionItem(title: '地图', page: MapDemo()),
          ActionItem(title: 'SensorDemo', page: SensorDemo()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      persistentFooterButtons: <Widget>[Icon(Icons.home),Icon(Icons.favorite),],
//      bottomNavigationBar: BottomAppBar(
//        child: Container(
//          alignment: Alignment.center,
//          width: MediaQuery.of(context).size.width,
//          height: 50,
//          child: Icon(Icons.home),
//        ),
//      ),
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'hello',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.wb_sunny),
                  onPressed: () {
                    if (themeProvider.nowBrightness == Brightness.light)
                      themeProvider.loadBrightness(Brightness.dark);
                    else
                      themeProvider.loadBrightness(Brightness.light);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(CupertinoIcons.shuffle),
                  onPressed: () {
                    themeProvider.loadThemeMode(ThemeMode.dark);
                  },
                ),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
