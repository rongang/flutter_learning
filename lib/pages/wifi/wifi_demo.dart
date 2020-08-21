import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/flutter_io_channels.dart';
import 'package:flutter_learning/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi/wifi.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';

class WifiInfoDemo extends StatefulWidget {
  @override
  _WifiInfoDemoState createState() => _WifiInfoDemoState();
}

class _WifiInfoDemoState extends State<WifiInfoDemo> {
  TextEditingController _wifiInfoTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wifiInfo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _wifiInfoTextField,
              maxLines: 10,
            ),
            FlatButton(
              child: Text('wifi频段'),
              onPressed: () async {
                if (Platform.isAndroid) {
                  WifiInfoWrapper wifiInfo = await WifiInfoPlugin.wifiDetails;
                  print('${wifiInfo.toString()}');
                  _wifiInfoTextField.text = wifiInfo.toString();
                  Utils.showDiglogg(
                      content: is24GWifi(wifiInfo.frequency)
                          ? '2.4G'
                          : is5GWifi(wifiInfo.frequency) ? '5G' : '未知');
                } else if (Platform.isIOS) {
                  Utils.showDiglogg(content: '仅支持安卓');
                }
              },
            ),
            FlatButton(
              child: Text('获取当前Wi-Fi列表'),
              onPressed: () async {
                ServiceStatus service =
                    await Permission.locationWhenInUse.serviceStatus;
                bool locationStates =
                    await Permission.locationWhenInUse.isGranted;
                if (!locationStates || service != ServiceStatus.enabled) {
                  Utils.showDiglogg(
                    content: '请开启定位权限',
                    press: (){
                      ChannelUtils.locationSettings();
                    }
                  );
                  Permission.locationWhenInUse.request().then((value) {
                    print('$value');
                  });
                }

                List<WifiResult> list = await Wifi.list('');
                print('$list');
//                Wifi.ip.then(print);
              },
            ),
          ],
        ),
      ),
    );
  }
}

bool is24GWifi(int frequency) {
  return frequency > 2400 && frequency < 2500;
}

bool is5GWifi(int frequency) {
  return frequency > 4900 && frequency < 5900;
}
