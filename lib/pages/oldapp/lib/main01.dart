import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Theme.of(context).platform == TargetPlatform.iOS
          ? CupertinoScrollbar(
              child: _buildListView(),
            )
          : Scrollbar(
              child: _buildListView(),
            ),
    );
  }

  Padding _buildListView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(children: generatorLists(30)),
      ),
    );
  }
}

List<Widget> generatorLists(n) {
  List<Widget> lst = [];
  for (var i = 0; i < n; i++) {
    lst.add(Container(
      decoration: BoxDecoration(color: Colors.grey[400]),
      width: double.infinity,
      height: 30,
      margin: EdgeInsets.symmetric(vertical: 8.0),
    ));
  }
  return lst;
}
