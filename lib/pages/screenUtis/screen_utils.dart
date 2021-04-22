import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/ScreenUtil.dart';

class ScreenUtilDemo extends StatefulWidget {
  @override
  _ScreenUtilDemoState createState() => _ScreenUtilDemoState();
}

class _ScreenUtilDemoState extends State<ScreenUtilDemo> {
  late double width, height;
  late double scale;

  @override
  void initState() {
    super.initState();
    scale = 0.5;
    width = 720;
    height = 1080;
  }
  windowReSize(){
    width =720*scale;
    height =1080*scale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('屏幕适配'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.network("https://pics1.baidu.com/feed/71cf3bc79f3df8dc933cfd640861068c461028bd.jpeg?token=cee36e9464fd586081f9bb798ff6b3df&s=B903B0560EE5A8CC16120E930300A09A"),
            // SizedBox(height: 200,),
            Slider(
              value: scale,
              label: (scale*10).floor().toString(),
              divisions: 10,
              onChanged: (double value) {
                scale = value;
                windowReSize();
                setState(() {});
              },
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: ScreenUtil.getFlexHeight(height),
              width: ScreenUtil.getFlexWidth(width),
              child: Image.asset(
                "assets/images/image.png",
              ),
            )
          ],
        ),
      ),
    );
  }
}
