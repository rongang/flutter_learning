import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditDemo extends StatefulWidget {
  @override
  _ProfileEditDemoState createState() => _ProfileEditDemoState();
}

class _ProfileEditDemoState extends State<ProfileEditDemo> {
  late File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              FormField(
                builder: (FormFieldState<dynamic> field) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final result = await ImagePicker().getImage(source: ImageSource.gallery);
                              if (result == null) return;
                              image = File(result.path);
                              setState(() {});
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 100,
                                  width: 100,
                                  child: CircleAvatar(
                                    backgroundImage: image.existsSync()
                                        ? FileImage(image) as ImageProvider
                                        : NetworkImage(
                                            'https://img-blog.csdnimg.cn/20190927151117521.png?x-oss-process=image/resize,m_fixed,h_224,w_224'),
                                  ),
                                ),
                                Opacity(
                                    opacity: 0.5,
                                    child: Icon(
                                      Icons.camera_enhance,
                                      size: 40,
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: 'rongang',
                              decoration: InputDecoration(border: InputBorder.none, prefixText: '昵称：\r\r'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.adb),
        onPressed: () {
          showBanner();
        },
      ),
    );
  }

  showBanner() {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
//            barrierColor: Colors.bla/k26,
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
              return SlideTransition(
                position: Tween(begin: Offset(0.0, -1.0), end: Offset(0.0, 0))
                    .chain(CurveTween(curve: Curves.fastOutSlowIn))
                    .animate(animation),
                child: Banner(),
              );
            }));
  }
}

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.black26,
        clipBehavior: Clip.none,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: 0,
              child: Container(
                height: MediaQuery.of(context).viewPadding.top,
              ),
            ),
            Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(20)),
                child: BackButton()),
          ],
        ),
      ),
    );
  }
}
