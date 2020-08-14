import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

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
        provider: CachedGoogleMapProvider(),
      ),
    );
  }
}

/// You can enable caching by using [CachedNetworkImageProvider] from cached_network_image package.
class CachedGoogleMapProvider extends MapProvider {
  const CachedGoogleMapProvider();

  @override
  ImageProvider getTile(int x, int y, int z) {
    //Can also use CachedNetworkImageProvider.
    return NetworkImage(
        'https://www.google.cn/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425');
  }
}
