import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapView extends StatefulWidget {
  GoogleMapView({
    super.key,
    required this.markers,
    required this.onTap,
    required this.cameraPosition,
  });

  Set<Marker> markers;
  Function onTap;
  CameraPosition cameraPosition;

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      compassEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: widget.cameraPosition,
      markers: widget.markers,
    );
  }
}
