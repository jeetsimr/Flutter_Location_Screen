import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  final String member;

  LocationScreen({required this.member});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _controller;
  DateTime selectedDate = DateTime.now();
  List<String> visitedLocations = [
    'Location 1',
    'Location 2',
    'Location 3',
  ];

  // Define initial camera position on map
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962), // Default coordinates
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  // Select date for filtering visited locations
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // TODO: Load data for selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.member} Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: visitedLocations.length,
              itemBuilder: (context, index) {
                return TimelineTile(
                  alignment: TimelineAlign.start,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    color: Colors.blue,
                    indicator: Icon(Icons.location_on, color: Colors.white, size: 16),
                  ),
                  endChild: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(visitedLocations[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
