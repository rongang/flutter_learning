import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

OverlayState overlayState;
OverlayEntry overlayEntry;

class ToastDemo extends StatelessWidget {
  ToastDemo() {
    overlayState = MyApp.navigatorKey.currentState?.overlay;
  }

  overTipTest() {
    // print('${MyApp.navigatorKey.currentState?.overlay?.context}');
    // print('${MyApp.navigatorKey.currentContext}');
    // print(MyApp.navigatorKey.currentState?.overlay?.context ==
    //     MyApp.navigatorKey.currentContext);
    // print(overlayState);
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.redAccent,
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      );
    });

    Future(() async {
      overlayState.insert(overlayEntry);
    });
  }

  Widget get toast => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text("This is a Custom Toast"),
          ],
        ),
      );

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   showToast();
  // }

  showToast() {
    FToast fToast = FToast();
    fToast.init(overlayState.context,
        overlayState: overlayState, alwaysNew: true);
    fToast.showToast(child: toast);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toast'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(),
          ElevatedButton(
            child: Text('隐藏tip'),
            onPressed: () {
              overlayEntry?.remove();
              overlayEntry=null;
            },
          ),
          OutlinedButton(
            child: Text('显示tip'),
            onPressed: () {
              overTipTest();
            },
          ),
          TextButton(
            child: Text('Toast'),
            onPressed: () {
              showToast();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.keyboard_hide),
        onPressed: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          // showToast();
        },
      ),
    );
  }
}
