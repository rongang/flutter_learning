import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliderDemo extends StatefulWidget {
  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double sliderValue = 0.0;
  double rangeSliderValueBegin = 0.0;
  double rangeSliderValueEnd = 0.5;
  RangeValues rangeValues;
  @override
  void initState() {
    rangeValues = RangeValues(rangeSliderValueBegin,rangeSliderValueEnd);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('1.20滑动按钮'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Container(
            height: 100,
            child: Slider(
              label: sliderValue.toString(),
              divisions: 10,
              value: sliderValue,
              onChanged: (double value) {
                print('$value');
                sliderValue = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            height: 100,
            child: RangeSlider(
              onChanged: (RangeValues value) {
                rangeValues = value;
                setState(() {});
              },
              values: rangeValues,
              divisions: 10,
              labels: RangeLabels(rangeSliderValueBegin.toString(),rangeSliderValueEnd.toString()),
            ),
          ),
          Container(
            height: 100,
            child: FlatButton(
              child: Text('显示键盘'),
              onPressed: (){
                SystemChannels.textInput.invokeMethod("TextInput.show");
              },
            ),
          )
        ],
      ),
    );
  }
}
