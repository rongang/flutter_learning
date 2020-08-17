import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipBoardPage extends StatefulWidget {
  @override
  _ClipBoardPageState createState() => _ClipBoardPageState();
}

class _ClipBoardPageState extends State<ClipBoardPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("$state");
    if (state == AppLifecycleState.resumed) getClipBoardContent();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  getClipBoardContent() async {
    ClipboardData clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    print('$clipboardData');
    if (clipboardData == null || clipboardData.text.trim() == '') return;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => CupertinoAlertDialog(
              title: Text('tip'),
              content: Text(
                clipboardData.text,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('监听粘贴板'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: '17806241090',
              textInputAction: TextInputAction.go,
              enableSuggestions: true,
              autovalidate: true,
              textAlign: TextAlign.end,
//              toolbarOptions: ToolbarOptions(copy: true,cut: true, paste: true, selectAll: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              keyboardType: TextInputType.number,
              validator: (input){
                if(input.isEmpty) return '用户名不能为空';
                return null;
              },
              decoration: InputDecoration(
                hintText: '178***',
//                errorText: 'error',
                labelText: '用户名',
                prefixText: '+86\r\r',
                border: InputBorder.none
              ),
            )
          ],
        ),
      ),
    );
  }
}
