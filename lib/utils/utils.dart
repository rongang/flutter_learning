import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/main.dart';

class Utils {
  static Widget showDiglogg({String content,Function press}) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: navigatorKey.currentState.overlay.context,
      builder: (context) {
        return Center(
          child: Container(
            height: 200,
            width: 300,
            child: CupertinoPopupSurface(
              child: Material(
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      alignment: Alignment.center,
                      child: CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: press??(){},
                            child: Text(content),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
