import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/map.dart';

class ParkingLocationScreen extends StatelessWidget {
  static String id = 'parking_location_screen';
  const ParkingLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Text(
              'Back',
              style: kTextStyle,
            ),
          ),
          leadingWidth: 100.0,
        ),
        body: GoogleMapView(
          markers: {
            Marker(
              markerId: MarkerId(
                args.latitude.toString(),
              ),
              position: LatLng(
                args.latitude,
                args.longitude,
              ),
            ),
          },
          onTap: () {},
          cameraPosition: CameraPosition(
            target: LatLng(
              args.latitude,
              args.longitude,
            ),
            zoom: 14.5,
          ),
        ),
      ),
    );
  }
}
