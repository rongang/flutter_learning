import 'dart:ui' as ui show Image, ImageFilter, TextHeightBehavior;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterdemo/pages/i18n/i18n_demo.dart';
import 'package:flutterdemo/pages/i18n/language_provider.dart';
import 'package:provider/provider.dart';

class I18nPage extends StatefulWidget {
  @override
  _I18nPageState createState() => _I18nPageState();
}

class _I18nPageState extends State<I18nPage> {
  String nowLanguage = '';
  LanguageProvider languageProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets edgeInsets = MediaQuery.of(context).padding;
    String title = I18nDemo.of(context).getItem('title');
    String content = I18nDemo.of(context).getItem('content');
    String language1 = I18nDemo.of(context).getItem('language1');
    String language2 = I18nDemo.of(context).getItem('language2');
    languageProvider = Provider.of<LanguageProvider>(context);
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'http://img.netbian.com/file/2018/0622/da3df84fa3f34c50010b42f105bf35fb.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
//        appBar: AppBar(
//          backgroundColor: Colors.transparent,
//          title: Text(title),
//          elevation: 0,
//        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: -5,
              child: SigmaWidget(
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: kToolbarHeight+edgeInsets.bottom,
                  color: Colors.transparent,
                  child: SafeArea(
                    bottom: false,
                    child: Text(title,style: TextStyle(fontSize: 20,),),
                  ),
                ),
              ),
            ),
            Positioned(
              top: kToolbarHeight + edgeInsets.top - 20,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SigmaWidget(
                      child: Text(
                    content,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
                  SigmaWidget(
                    child: PopupMenuButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(languageProvider.nowLanguage),
                          Icon(
                            Icons.text_fields,
                            size: 40,
                          ),
                        ],
                      ),
                      onSelected: (value) {
                        if (value == language1) {
                          languageProvider.loadLanguage(Locale('zh'));
                          I18nDemo.delegate.load(Locale('zh'));
                          languageProvider.nowLanguage = '简体中文';
                        } else if (value == language2) {
                          languageProvider.loadLanguage(Locale('en'));
                          languageProvider.nowLanguage = 'english';
                          I18nDemo.delegate.load(Locale('en'));
                        }
                      },
                      offset: Offset(-30, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: ListTile(title: Text(language1)),
                            value: language1,
                          ),
                          PopupMenuItem(
                            child: ListTile(title: Text(language2)),
                            value: language2,
                          ),
                        ];
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: SigmaWidget(
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: SigmaWidget(
                          child: IconButton(
                            icon: Icon(Icons.style),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: SigmaWidget(
                          child: IconButton(
                            icon: Icon(Icons.camera),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                  child: BackButton(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
//        bottomNavigationBar: BottomAppBar(
//          child: Container(
//            width: size.width,
//            height: 100,
//            color: Colors.teal[200],
//          ),
//        ),
      ),
    );
  }
}

class SigmaWidget extends StatelessWidget {
  final Widget child;

  const SigmaWidget({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ),
    );
  }
}
