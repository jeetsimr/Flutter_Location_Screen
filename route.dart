import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteScreen extends StatefulWidget {
  final String member;
  final LatLng startLocation;
  final LatLng stopLocation;
  final double totalKms;
  final Duration totalDuration;

  RouteScreen({
    required this.member,
    required this.startLocation,
    required this.stopLocation,
    required this.totalKms,
    required this.totalDuration,
  });

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  GoogleMapController? _controller;
  List<LatLng> routePoints = [];

  @override
  void initState() {
    super.initState();
    // Example route points between start and stop locations
    routePoints = [
      widget.startLocation,
      LatLng(37.4221, -122.0841), // Intermediate point
      widget.stopLocation,
    ];
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.member} Route Details'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: widget.startLocation,
                zoom: 14.0,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  points: routePoints,
                  color: Colors.blue,
                  width: 5,
                ),
              },
              markers: {
                Marker(
                  markerId: MarkerId('start'),
                  position: widget.startLocation,
                  infoWindow: InfoWindow(title: 'Start Location'),
                ),
                Marker(
                  markerId: MarkerId('stop'),
                  position: widget.stopLocation,
                  infoWindow: InfoWindow(title: 'Stop Location'),
                ),
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start Location: ${widget.startLocation.latitude}, ${widget.startLocation.longitude}'),
                  Text('Stop Location: ${widget.stopLocation.latitude}, ${widget.stopLocation.longitude}'),
                  Text('Total KMs: ${widget.totalKms.toStringAsFixed(2)}'),
                  Text('Total Duration: ${widget.totalDuration.inMinutes} mins'),
                  // Show stop time information if available
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
