import 'dart:async';

import 'package:flutter/material.dart';

class StreamDemo extends StatefulWidget {
  @override
  _StreamDemoState createState() => _StreamDemoState();
}

class _StreamDemoState extends State<StreamDemo> {
  late StreamSubscription _streamSubscription;
  late StreamController<String> _streamDemo;
  late StreamSink _sinkDemo;
  String _data = '...';
  @override
  void initState() {
    super.initState();

    print('Create a stream');
//    Stream<String> _streamDemo = Stream.fromFuture(fetchData());
//    _streamDemo = StreamController<String>();
    _streamDemo = StreamController.broadcast();
    _sinkDemo = _streamDemo.sink;

    print('Start listening on a stream');
    _streamSubscription = _streamDemo.stream.listen(onData, onError: onError, onDone: onDone);
    _streamDemo.stream.listen(onDataTwo, onError: onError, onDone: onDone);
    print('Initialize stream');
  }

  @override
  dispose() {
    super.dispose();
    _streamDemo.close();
  }

  onData(String data) {
    setState(() {
      _data = data;
    });
    print('data => $data');
  }

  onDataTwo(String data) {
    print('dataTwo => $data');
  }

  Future<String> fetchData() async {
//    throw Exception('Some errors happened');
    return Future.delayed(Duration(seconds: 5), () => 'hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamDemo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//            Text(_data),
            StreamBuilder<String>(
              stream: _streamDemo.stream,
              initialData: '...',
              builder: (context, snapshot) {
                return Text('${snapshot.data}');
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBar(
                  children: [
                    FlatButton(
                      child: Text('add'),
                      onPressed: _addDataToStream,
                    ),
                    FlatButton(
                      child: Text('Pause'),
                      onPressed: _pauseStream,
                    ),
                    FlatButton(
                      child: Text('Resume'),
                      onPressed: _resumeStream,
                    ),
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: _cancelStream,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  onError(error) {
    print('error');
  }

  void onDone() {
    print('Done!');
  }

  void _pauseStream() {
    _streamSubscription.pause();
    print('Stream pause');
  }

  void _resumeStream() {
    _streamSubscription.resume();
    print('Stream resume');
  }

  void _cancelStream() {
    _streamSubscription.cancel();
    print('Stream cancel');
  }

  void _addDataToStream() async {
    print('Add data to Stream');
    String data = await fetchData();
//    _streamDemo.add(data);
    _sinkDemo.add(data);
  }
}
