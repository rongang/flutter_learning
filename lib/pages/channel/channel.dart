import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/flutter_io_channels.dart';

class ChannelDemo extends StatefulWidget {
  @override
  _ChannelDemoState createState() => _ChannelDemoState();
}

class _ChannelDemoState extends State<ChannelDemo> {
  @override
  void initState() {
    super.initState();
    ChannelUtils.initReceiveOrigin(onEvent: onEvent);
  }

  onEvent(event) {
    print('ChannelDemo--event  $event');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('原生通信'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ChannelUtils.startTimer();
              },
              label: Text('start event'),
              icon: Icon(Icons.play_arrow),
            ),
            OutlinedButton.icon(
              onPressed: () {
                ChannelUtils.cancelTimer();
              },
              label: Text('cancel event'),
              icon: Icon(Icons.cancel),
            ),
          ],
        ),
      ),
    );
  }
}
