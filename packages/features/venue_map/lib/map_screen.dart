import 'package:datasource_core/models/venue_item.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final List<VenueItem> venues;

  const MapScreen({super.key, required this.venues});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initMarkers();
  }

  void _initMarkers() {
    for (var venue in widget.venues) {
      _markers.add(
        Marker(
          markerId: MarkerId(venue.name),
          position: LatLng(venue.lat,venue.lng),
          infoWindow: InfoWindow(
            title: venue.name,
            snippet: venue.location,
            onTap: () {
              // Optional: Navigate to details
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstVenue = widget.venues.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Venues Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(firstVenue.lat, firstVenue.lng),
          zoom: 12,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: _markers,
      ),
    );
  }
}
