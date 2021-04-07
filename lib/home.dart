import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task/custom_tile.dart';
import 'package:task/data_model.dart';
import 'package:task/my_map.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Data> data = [
    Data(start: 'Lahore', destination: 'Karachi', distance: 1210),
    Data(start: 'Lahore', destination: 'Faisalabad', distance: 180),
    Data(start: 'Lahore', destination: 'Sialkot', distance: 124),
    Data(start: 'Lahore', destination: 'Islamabad', distance: 377),
  ];
  Map coordinates = {
    'Lahore': LatLng(31.52, 74.36),
    'Karachi': LatLng(24.86, 67.00),
    'Faisalabad': LatLng(31.45, 73.14),
    'Sialkot': LatLng(32.49, 74.53),
    'Islamabad': LatLng(33.68, 73.05),
  };
  bool reverseList = false;
  Marker _origin = Marker(
    markerId: MarkerId('Origin'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  );
  Marker _destination = Marker(
    markerId: MarkerId('Destination'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );

  void _setMarkers(
      LatLng originPosition, LatLng destPosition, String origin, String dest) {
    _origin = Marker(
      markerId: MarkerId(origin),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      position: originPosition,
    );
    _destination = Marker(
      markerId: MarkerId(dest),
      position: destPosition,
    );
    setState(() {});
  }

  List<CustomTile> getTiles() {
    List<CustomTile> tiles = [];
    data.sort((a, b) => (a.distance).compareTo(b.distance));
    if (reverseList) {
      data = List.from(data.reversed);
    }
    for (var item in data) {
      String title = item.start + ' to ' + item.destination;
      String distance = item.distance.toString() + ' km';
      CustomTile tile = CustomTile(
        title: title,
        distance: distance,
        onTap: () => _setMarkers(coordinates[item.start],
            coordinates[item.destination], item.start, item.destination),
      );
      tiles.add(tile);
    }
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MyMap(
            origin: _origin,
            destination: _destination,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blueAccent,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      reverseList = !reverseList;
                    });
                  },
                  icon: Icon(
                    Icons.list,
                  ),
                  color: Colors.white,
                ),
              ),
              Container(
                width: screenWidth,
                height: 90,
                child: ListView(
                    scrollDirection: Axis.horizontal, children: getTiles()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
