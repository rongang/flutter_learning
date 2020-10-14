//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:notus/convert.dart';
//import 'package:zefyr_plus/zefyr.dart';
//
//class issuesMessagePage extends StatefulWidget {
//  @override
//  _issuesMessagePageState createState() => _issuesMessagePageState();
//}
//
//class _issuesMessagePageState extends State<issuesMessagePage> {
//  final TextEditingController _controller = new TextEditingController();
//  final ZefyrController _zefyrController = new ZefyrController(NotusDocument());
//  final FocusNode _focusNode = new FocusNode();
//  String _title = "";
//  var _delta;
//  var json;
//  String string;
//  var plainText;
//
////  _delta = _zefyrController.document.toDelta();
////  notusMarkdown.encode(_delta);
//
//  @override
//  void initState() {
//    _controller.addListener(() {
//      print("_controller.text:${_controller.text}");
//      setState(() {
//        _title = _controller.text;
//      });
//    });
//
//    _zefyrController.document.changes.listen((change) {
//      setState(() {
//        _delta = _zefyrController.document.toDelta();
//        json = _zefyrController.document.toJson();
//        string = _zefyrController.document.toString();
//        plainText = _zefyrController.document.toPlainText();
//      });
//    });
//
//    super.initState();
//  }
//
//  void dispose() {
//    _controller.dispose();
//    _zefyrController.dispose();
//    super.dispose();
//  }
//
//  _submit() {
//    print("==============================");
////    print("_delta:$_delta");
////    print("json:$json");
////    print("string:$string");
////    print("plainText:$plainText");
//    String mk = notusMarkdown.encode(_delta);
//    print("mk:$mk");
//    if (_title.trim().isEmpty) {
//      Fluttertoast.showToast(
//          msg: '标题不能为空',
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Theme.of(context).primaryColor,
//          textColor: Colors.white,
//          fontSize: 16.0);
//    }
////    else {
////      DataUtils.feedback({'title': _title, "body": mk}).then((result) {
////      });
////      print(result);
////    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('反馈/意见'),
//          actions: <Widget>[
//            FlatButton.icon(
//              onPressed: () {
//                _submit();
//              },
//              icon: Icon(
//                Icons.near_me,
//                color: Colors.white,
//                size: 12,
//              ),
//              label: Text(
//                '发送',
//                style: TextStyle(color: Colors.white),
//              ),
//            )
//          ],
//          elevation: 1.0,
//        ),
//        body: ZefyrScaffold(
//          child: Padding(
//            padding: EdgeInsets.all(8),
//            child: ListView(
//              children: <Widget>[
//                Text('输入标题：'),
//                new TextFormField(
//                  maxLength: 50,
//                  controller: _controller,
//                  decoration: new InputDecoration(
//                    hintText: 'Title',
//                  ),
//                ),
//                Text('内容：'),
//                _descriptionEditor(),
//              ],
//            ),
//          ),
//        ));
//  }
//
//  Widget _descriptionEditor() {
//    final theme = new ZefyrThemeData(
//      toolbarTheme: ToolbarTheme.fallback(context).copyWith(
//        color: Colors.grey.shade800,
//        toggleColor: Colors.grey.shade900,
//        iconColor: Colors.white,
//        disabledIconColor: Colors.grey.shade500,
//      ),
//    );
//
//    return ZefyrTheme(
//      data: theme,
//      child: ZefyrField(
//        height: 400.0,
//        decoration: InputDecoration(labelText: 'Description'),
//        controller: _zefyrController,
//        focusNode: _focusNode,
//        autofocus: true,
//        physics: ClampingScrollPhysics(),
//      ),
//    );
//  }
//}
//
