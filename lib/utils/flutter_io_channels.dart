import 'package:flutter/services.dart';

const ChannelUtil = MethodChannel('flutter.io/utils');
const Channel_Location = "locationSettings";


class ChannelUtils{
  static locationSettings(){
    ChannelUtil.invokeMethod(Channel_Location,[]);
  }
}