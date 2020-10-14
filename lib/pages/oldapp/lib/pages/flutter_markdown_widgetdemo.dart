import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownPage extends StatefulWidget {
  final String assetsPath;
  final String markdownData = '''
## Titles
  
```
class MarkdownHelper {


  Map<String, Widget> getTitleWidget(m.Node node) => title.getTitleWidget(node);

  Widget getPWidget(m.Element node) => p.getPWidget(node);

  Widget getPreWidget(m.Node node) => pre.getPreWidget(node);

}
```

Html Image:

<img  height="250" src="http://img.netbian.com/file/2020/0518/75e66fb283f3af72fbe1b51a811b90fe.jpg"/>

Video:

<video src="https://www.bilibili.com/video/BV1MK411s7Xt/">

''';

  const MarkdownPage({Key key, this.assetsPath})
      : super(key: key);

  @override
  _MarkdownPageState createState() => _MarkdownPageState();
}

class _MarkdownPageState extends State<MarkdownPage> {
  ///key: [isEnglish] , value: data
  Map<bool, String> dataMap = {};
  String data;
  final TocController controller = TocController();
  bool isEnglish = true;

  @override
  void initState() {
    if (widget.assetsPath != null) {
      loadData(widget.assetsPath);
    } else {
      this.data = widget.markdownData;
    }
    super.initState();
  }

  void loadData(String assetsPath) {
    if (dataMap[isEnglish] != null) {
      data = dataMap[isEnglish];
      refresh();
      return;
    }
    rootBundle.loadString(assetsPath).then((data) {
      dataMap[isEnglish] = data;
      this.data = data;
      refresh();
    });
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
//    bool isMobile = PlatformDetector.isMobile || PlatformDetector.isWebMobile;
    bool isMobile = false;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
        title: Text('Markdown Page'),
        elevation: 0.0,
        backgroundColor: Colors.black,
      )
          : null,
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : (isMobile ? buildMobileBody() : buildWebBody()),
      floatingActionButtonLocation: isMobile
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.assetsPath != null
          ? Row(
        mainAxisAlignment: isMobile
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.end,
        children: <Widget>[
          isMobile
              ? FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) => buildTocList());
            },
            child: Icon(Icons.format_list_bulleted),
            heroTag: 'list',
          )
              : SizedBox(),
          FloatingActionButton(
            onPressed: () {
              isEnglish = !isEnglish;
              loadData(
                  isEnglish ? 'assets/demo_en.md' : 'assets/demo_zh.md');
            },
            child: Text(isEnglish ? '简中' : 'EN'),
            heroTag: 'language',
          ),
        ],
      )
          : null,
    );
  }

  Widget buildTocList() => TocListWidget(controller: controller);

  Widget buildMarkdown() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: MarkdownWidget(
        data: data,
        controller: controller,
        styleConfig: StyleConfig(
            pConfig: PConfig(
              linkGesture: (linkChild, url) {
                return GestureDetector(
                  child: linkChild,
                  onTap: () => _launchURL(url),
                );
              },
            ),
            preConfig: PreConfig(
              preWrapper: (child, text) =>
                  buildCodeBlock(child, text, isEnglish),
            ),
            markdownTheme:
//            isDarkNow ? MarkdownTheme.darkTheme : MarkdownTheme.lightTheme),
            MarkdownTheme.darkTheme),
      ),
    );
  }

  Widget buildCodeBlock(Widget child, String text, bool isEnglish) {
    return Stack(
      children: <Widget>[
        child,
        Container(
          margin: EdgeInsets.only(top: 5, right: 5),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              Widget toastWidget = Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff006EDF), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(
                        4,
                      )),
                      color: Color(0xff007FFF)),
                  width: 150,
                  height: 40,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        isEnglish ? 'Copy successful' : '复制成功',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
              ToastWidget().showToast(context, toastWidget, 500);
            },
            icon: Icon(
              Icons.content_copy,
              size: 10,
            ),
          ),
        )
      ],
    );
  }

  Widget buildMobileBody() {
    return buildMarkdown();
  }

  Widget buildWebBody() {
    return Row(
      children: <Widget>[
        Expanded(child: buildTocList()),
        Expanded(
          child: buildMarkdown(),
          flex: 3,
        )
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ToastWidget {
  ToastWidget._internal();

  static ToastWidget _instance;

  factory ToastWidget() {
    _instance ??= ToastWidget._internal();
    return _instance;
  }

  bool isShowing = false;

  void showToast(BuildContext context, Widget widget, int milliseconds) {
    if (!isShowing) {
      isShowing = true;
      FullScreenDialog.getInstance().showDialog(
        context,
        widget,
      );
      Future.delayed(
          Duration(
            milliseconds: milliseconds,
          ), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          isShowing = false;
        } else {
          isShowing = false;
        }
      });
    }
  }
}

class FullScreenDialog {
  static FullScreenDialog _instance;

  static FullScreenDialog getInstance() {
    if (_instance == null) {
      _instance = FullScreenDialog._internal();
    }
    return _instance;
  }

  FullScreenDialog._internal();

  void showDialog(BuildContext context, Widget child) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (ctx, anm1, anm2) {
          return child;
        }));
  }
}