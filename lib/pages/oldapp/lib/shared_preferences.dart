// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  SharedPreferencesDemo({Key key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;
  Future<List> _inputList;


  TextEditingController _controller = TextEditingController();

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }
  Future<void> _saveInputHistory(String input) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> history = prefs.getStringList("history")??[];
    history.add(input);

    setState(() {
      _inputList = prefs.setStringList("history", history).then((bool success) {
        return history;
      });
    });
  }
  Future<void> _deleteInputHistory(String input) async {
    final SharedPreferences prefs = await _prefs;
    final List<String> history = prefs.getStringList("history")??[];
    history.remove(input);

    setState(() {
      _inputList = prefs.setStringList("history", history).then((bool success) {
        return history;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return (prefs.getInt('counter') ?? 0);
    });
    _inputList = _prefs.then((SharedPreferences prefs) {
      return (prefs.getStringList('history') ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height:200,
            child: Center(
                child: FutureBuilder<int>(
                    future: _counter,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                              'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
                                  'This should persist across restarts.',
                            );
                          }
                      }
                    })),
          ),
          Container(
            child: TextField(
              autofocus: true,
              controller: _controller,
            ),
          ),
          Container(
            height:100,
            child: Center(
                child: FutureBuilder<List>(
                    future: _inputList,
                    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                              'history==============> ${snapshot.data}',
                            );
                          }
                      }
                    })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _incrementCounter();
          print(_controller.text);
          _deleteInputHistory(_controller.text);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}