import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labouchee/widgets/custom_app_bar.dart';

class GMAP extends StatefulWidget {
  final double? latitude, longitude;
  const GMAP({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  _GMAPState createState() => _GMAPState();
}

class _GMAPState extends State<GMAP> {
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng _lastMapPosition;

  void initState() {
    // TODO: implement initState
    super.initState();
    _center = LatLng(widget.latitude!, widget.longitude!);
    _lastMapPosition = _center;
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_lastMapPosition.toString()),
      position: _lastMapPosition,
      infoWindow: const InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  late LatLng _center;

  final Set<Marker> _markers = {};

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed(LatLng position) {
    _lastMapPosition = position;

    setState(() {
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: const InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _closeMap() {
    Navigator.of(context)
        .pop([_lastMapPosition.latitude, _lastMapPosition.longitude]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(title: 'Select Location'),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              zoomControlsEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onTap: (result) {
                _onAddMarkerButtonPressed(result);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.map, size: 36.0),
                      heroTag: "Change View",
                    ),
                    const SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _closeMap,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.check_circle_rounded, size: 36.0),
                      heroTag: "Close Screen",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
