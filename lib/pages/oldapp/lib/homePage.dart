
import './pages/barcodedemo/scan.dart';
import './pages/scanBarCode.dart';
import './pages/scrolldeletedemo.dart';
import './pages/sliverdemo/sliverDemo02.dart';
import './Utils/customrotute.dart';
import './pages/MarkDown.dart';
import './pages/cliprectdemo.dart';
import './pages/customofficialwebviewdemo.dart';
import './pages/customsliverviewdemo.dart';
import './pages/customwebviewdemo.dart';
import './pages/flutter_markdown_widgetdemo.dart';
import './pages/herodemo.dart';
import './pages/htmlconvertdemo.dart';
import './pages/officialwebview.dart';
import './pages/positionListViewDemo.dart';
import './pages/richtextdemo.dart';
import './pages/richtextdemo2.dart';
import './pages/searchbardemo.dart';
import './pages/shareImage.dart';
import './pages/webview_mix_widget.dart';
import 'animation/animation_1.dart';
import 'animation/animation_2.dart';
import 'feizhu_widget.dart';
import 'main.dart';
//import 'pages/animationdemo/counter_demo.dart';
import 'pages/animation/animation_demo.dart';
import 'pages/fluttertoastdemo.dart';
import 'pages/futureDemo.dart';
import 'pages/guidance/guidance_demo.dart';
import 'pages/i18n/i18n_demo_page.dart';
import 'pages/sliverdemo/sliverDemo01.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(
        curve: Curves.fastOutSlowIn, parent: animationController);
    animation = Tween(begin: 0.0, end: 2.0).animate(animationController);
    //动画正向进行
    animationController.forward();
    //动画反复进行
//    animationController.reverse();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: animation,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
                child: InkWell(
                  child: ListTile(
                    title: Text('HeroDemo'),
                    leading: Hero(
                      tag: 'hero',
                      child: Image.network(
                        'http://img.netbian.com/file/2020/0524/b1bb0802801c2d1ae6448609ce8d5ea4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => HeroDemo()));
                  },
                )),
//            ActionItem(title: 'CounterDemo', page: CounterDemo()),

            ActionItem(title: 'GuidanceDemo', page: GuidanceDemo()),
            ActionItem(title: '动画', page: AnimationDemo()),
            ActionItem(title: 'FutureDemo', page: FutureDemo()),
            ActionItem(title: 'I18nDemoPage', page: I18nDemoPage()),
            ActionItem(title: 'SliverDemo01', page: SliverDemo01()),
            ActionItem(title: 'SliverDemo02', page: SliverDemo02()),
            ActionItem(title: '动画二', page: animation_2()),
            ActionItem(title: '贝塞尔曲线切割', page: ClipRectDemo()),
            ActionItem(title: 'sliverView', page: CustomSliverViewDemo()),
            ActionItem(title: 'webView', page: CustomWebViewDemo()),
            ActionItem(
                title: 'officialWebViewDemo',
                page: CustomOfficialWebViewDemo()),
            ActionItem(title: 'officialWebView', page: WebViewExample()),
            ListTile(
              title: Text('searchBar'),
              onTap: () {
                showSearch(context: context, delegate: SearchBarDemo());
              },
            ),
            ActionItem(title: 'RichTextDemo', page: RichTextDemo()),
//            ActionItem(title: 'RichTextEdit', page: issuesMessagePage()),
            ActionItem(title: 'MarkDown', page: MarkDownDemo()),
            ActionItem(title: 'htmlConvertDemo', page: HtmlConvertDemo()),
            ActionItem(title: 'flutter_markdown_widget', page: MarkdownPage()),
//            ActionItem(title: 'webview_mix_widget', page: WebViewMixWidget()),
            ActionItem(title: 'FEIZHUWidget', page: FEIZHUWidget()),
            ActionItem(
                title: '定位ListView', page: ScrollablePositionedListPage()),
            ActionItem(title: '截图分享', page: ShareImageDemo()),
//            ActionItem(title: 'toast', page: FlutterToastDemo()),
            ActionItem(title: 'ScrollDeleteDemo', page: ScrollDeleteDemo()),
            ActionItem(title: '二维码生成', page: ExampleApp()),
            ActionItem(title: '扫码', page: MyAppScan()),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String title;
  final Widget page;

  const ActionItem({Key key, this.title, this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(title),
        onTap: () {
          Navigator.of(context).push(CustomRoute(widget: page));
        },
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
