import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class Map1 extends StatefulWidget {
  @override
  _Map1State createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  MapController mapController = MapController(location: LatLng(1.0, 1.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地图一'),
      ),
      body: Map(
        controller: mapController,
        builder: (BuildContext context, int x, int y, int z) {
          return Container();
        },
      ),
    );
  }
}
