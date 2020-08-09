import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarPage5 extends StatefulWidget {
  @override
  _CalendarPage5State createState() => _CalendarPage5State();
}

class _CalendarPage5State extends State<CalendarPage5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('今天周几？'),
              onPressed: (){
                print('${DateTime.now().weekday}');
              },
            ),
            RaisedButton(
              child: Text('周一'),
              onPressed: (){
                print('${DateTime.now().subtract(Duration(days: DateTime.now().weekday-1))}');
              },
            ),
            RaisedButton(
              child: Text('周末'),
              onPressed: (){
                print('${DateTime.now().subtract(Duration(days: 7 - DateTime.now().weekday))}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
