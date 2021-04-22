import 'package:flutter/material.dart';
import 'package:flutter_learning/pages/oldapp/lib/Utils/customrouteImage.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

const String _markdownData = '''# Markdown Example

Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.

## Titles

Setext-style

```
This is an H1
=============

This is an H2
-------------
```

Atx-style

```
# This is an H1

## This is an H2

###### This is an H6
```

Select the valid headers:

- [x] `# hello`
- [ ] `#hello`

## Links

[百度](https://www.baidu.com)

```
[inline-style](https://www.google.cn)

[reference-style][Google]
```

## Images

![](http://img.netbian.com/file/2020/0518/75e66fb283f3af72fbe1b51a811b90fe.jpg)
![](http://img.netbian.com/file/2020/0518/75e66fb283f3af72fbe1b51a811b90fe.jpg)
![](http://img.netbian.com/file/2020/0518/75e66fb283f3af72fbe1b51a811b90fe.jpg)
![](http://img.netbian.com/file/2020/0518/75e66fb283f3af72fbe1b51a811b90fe.jpg)

## Tables

| Syntax                                  | Result                                |
| --------------------------------------- | ------------------------------------- |
| `*italic 1*`                            | *italic 1*                            |
| `_italic 2_`                            | _italic 2_                            |
| `**bold 1**`                            | **bold 1**                            |
| `__bold 2__`                            | __bold 2__                            |
| `This is a ~~strikethrough~~`           | This is a ~~strikethrough~~           |
| `***italic bold 1***`                   | ***italic bold 1***                   |
| `___italic bold 2___`                   | ___italic bold 2___                   |
| `***~~italic bold strikethrough 1~~***` | ***~~italic bold strikethrough 1~~*** |
| `~~***italic bold strikethrough 2***~~` | ~~***italic bold strikethrough 2***~~ |

## Styling

Style text as _italic_, __bold__, ~~strikethrough~~, or `inline code`.

- Use bulleted lists
- To better clarify
- Your points

## Code blocks

Formatted Dart code looks really pretty too:

```
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Markdown(data: markdownData),
    ),
  ));
}
```
[Google]: https://www.google.cn/

[www.baidu.com]: (www.baidu.com)
## Markdown widget

This is an example of how to create your own Markdown widget:

    Markdown(data: 'Hello _world_!');

Enjoy!





''';
const String _html = '''<h1>hello world</h1>''';

class MarkDownDemo extends StatefulWidget {
  @override
  _MarkDownDemoState createState() => _MarkDownDemoState();
}

class _MarkDownDemoState extends State<MarkDownDemo> {
  final ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markdown Demo'),
      ),
      body: SafeArea(
        child: Markdown(
          controller: controller,
//          selectable: true,
          data: _markdownData,
          imageDirectory: 'https://raw.githubusercontent.com',
          onTapLink: (String text, String? href, String title) async {
            print(text);
//            Navigator.push(context, CustomRoute(widget: WebViewExample(url:'https://www.baidu.com')));
            await launch('http://www.baidu.com',
                forceSafariVC: false, forceWebView: false, statusBarBrightness: Brightness.light);
          },
          styleSheet: MarkdownStyleSheet(a: TextStyle(color: Colors.pinkAccent), p: TextStyle(color: Colors.blueAccent)),
          imageBuilder: (Uri uri, String? title, String? alt) => GestureDetector(
            child: Image.network(
              uri.toString(),
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  CustomRouteImage(Scaffold(
                      backgroundColor: Colors.black,
                      body: Center(
                          child: GestureDetector(
                        child: Image.network(
                          uri.toString(),
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )))));
            },
          ),
          /*imageBuilder: (uri) => Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child: GestureDetector(
                  child: Image.network(
                    uri.toString(),
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
          ),*/
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () => controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
}
