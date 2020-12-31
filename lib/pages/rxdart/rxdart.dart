import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class RxDartDemo extends StatefulWidget {
  @override
  _RxDartDemoState createState() => _RxDartDemoState();
}

class _RxDartDemoState extends State<RxDartDemo> {
  PublishSubject<String> _publishSubject;

  @override
  void initState() {
    super.initState();
//    PublishSubject _subject = PublishSubject<String>();
//    BehaviorSubject<String> _subject = BehaviorSubject<String>();
    ReplaySubject<String> _subject = ReplaySubject<String>(maxSize: 2);

    _subject.add('hola');
    _subject.add('hello');
    _subject.add('hi');
    _subject.listen(print);
    _subject.listen((value) {
      return print('listen 2: ${value.toUpperCase()}');
    });

    _subject.close();
    _publishSubject = PublishSubject<String>();
    _publishSubject
      .debounceTime(Duration(milliseconds: 500))
      .where((item) => item.length>9)
      .map((item) => 'item: $item')
      .listen(print);
  }

  @override
  void dispose() {
    super.dispose();
    _publishSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('RxDartDemo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  _publishSubject.add('input $value');
                },
                onSubmitted: (value) {
                  _publishSubject.add('submit $value');
                },
              ),
              SizedBox(height: 300,),
              TextButton(onPressed: (){}, child: Icon(Icons.fingerprint))
            ],
          ),
        ),
      ),
    );
  }
}
