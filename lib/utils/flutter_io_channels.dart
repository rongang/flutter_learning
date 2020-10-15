import 'package:flutter/services.dart';

const ChannelUtil = MethodChannel('flutter.io/utils');
const Channel_Location = "locationSettings";
const Channel_Cancel_Timer = "cancelTimer";
const Channel_Start_Timer = "startTimer";
const receiveOriginMessageEventChannel = EventChannel('receiveOriginMessageEventChannel');


class ChannelUtils{
  static locationSettings(){
    ChannelUtil.invokeMethod(Channel_Location,[]);
  }
  static startTimer(){
    ChannelUtil.invokeMethod(Channel_Start_Timer);
  }
  static cancelTimer(){
    ChannelUtil.invokeMethod(Channel_Cancel_Timer);
  }
  static initReceiveOrigin({Function onEvent=_onEvent, Function onError=_onError}){
    receiveOriginMessageEventChannel.receiveBroadcastStream().listen(onEvent,onError: onError);
  }
  static _onEvent(event){
    print('event$event');
  }
  static _onError(error){
    print('error$error');
  }
}