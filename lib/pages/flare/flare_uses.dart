import 'package:flutter/material.dart';
import 'package:flutter_learning/pages/flare/flare_demo.dart';

class FlareUsersPage extends StatefulWidget {
  @override
  _FlareUsersPageState createState() => _FlareUsersPageState();
}

class _FlareUsersPageState extends State<FlareUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          color: Colors.blue[100],
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue[300],
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue[500],
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue[700],
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue[700],
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Positioned(
            bottom: 0,
//            left: 0,
//            right: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: FlareDemo(),
            ),
          ),
        ],
      ),
    );
  }
}
