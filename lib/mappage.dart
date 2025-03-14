import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class Mappage extends StatefulWidget {
  const Mappage({super.key});

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  final MapController _mapController = MapController();
  double initialZoom = 10.0;
  LocationData? _currentlocation;
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getuserLocation();
  }

  Future<void> _getuserLocation() async {
    bool _serviceenabled;
    PermissionStatus _permissiongranted;
    _serviceenabled = await _location.serviceEnabled();
    if (!_serviceenabled) {
      _serviceenabled = await _location.requestService();
      if (!_serviceenabled) {
        return;
      }
    }

    _permissiongranted = await _location.hasPermission();
    if (_permissiongranted == PermissionStatus.denied) {
      _permissiongranted = await _location.requestPermission();
      if (_permissiongranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await _location.getLocation();
    setState(() {
      _currentlocation = locationData;
    });

    _mapController.move(
      LatLng(locationData.latitude!, locationData.longitude!),
      initialZoom,
    );
  }

  void increaseZoom() {
    setState(() {
      initialZoom += 1;
      _mapController.move(LatLng(0,0), initialZoom);
    });
  }

  void reduceZoom() {
    setState(() {
      if (initialZoom > 1) {
        initialZoom -= 1;
        _mapController.move(LatLng(0,0), initialZoom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(initialCenter: LatLng(0,0), initialZoom: initialZoom),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if(_currentlocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(_currentlocation!.latitude!, _currentlocation!.longitude!),
                width: 20,
                height: 20,
                child: Icon(Icons.location_pin, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getuserLocation,
            mini: true,
            child: Icon(Icons.my_location),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: increaseZoom,
            mini: true,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: reduceZoom,
            mini: true,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
