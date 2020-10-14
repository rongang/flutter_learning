import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    print('NewsPage Init');
    super.initState();
  }

     void _handlePress() {
       HapticFeedback.vibrate();
     }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('NewsPage Build');
    return Center(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return ExpansionTile(
          leading: Icon(Icons.done),
          initiallyExpanded: false,
          title: Text('下拉收起模态框'),
          children: <Widget>[
            RichText(
              text: TextSpan(
                  text: 'textSpan',
                  style: TextStyle(color: Colors.pinkAccent,fontSize: 50),
                  children: [
                    TextSpan(text: '111111111111111111111111111',style: TextStyle(color: Colors.amberAccent)),
                    TextSpan(text: '2'),
                    TextSpan(text: '3'),
                  ],
                  semanticsLabel: 'semanticsLabel'),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
            ),
          ],
        );
      },
      itemCount: 1,
    ));
  }

  @override
  bool get wantKeepAlive => false;
}
