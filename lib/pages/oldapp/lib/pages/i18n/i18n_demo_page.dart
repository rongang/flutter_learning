import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'localization_demo.dart';

class I18nDemoPage extends StatefulWidget {
  @override
  _I18nDemoPageState createState() => _I18nDemoPageState();
}

class _I18nDemoPageState extends State<I18nDemoPage> {
  String title,content;
  @override
  Widget build(BuildContext context) {
    print('intl_localization: ${S.of(context)}');
    title = LocalizationDemo.of(context).title;
    content = LocalizationDemo.of(context).content;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(title,style: Theme.of(context).textTheme.headline3,),
                background: Column(
                  children: <Widget>[
                    Icon(Icons.flight_takeoff,size: 100,)
                  ],
                ),
              )
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Text(content,style:Theme.of(context).textTheme.headline2),
            ),
          )
        ],
      ),
    );
  }
}
