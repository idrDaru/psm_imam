import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/map.dart';
import 'package:psm_imam/view_models/parking_location_view_model.dart';

class ParkingLocationScreen extends StatefulWidget {
  static String id = 'parking_location_screen';
  const ParkingLocationScreen({super.key});

  @override
  State<ParkingLocationScreen> createState() => _ParkingLocationScreenState();
}

class _ParkingLocationScreenState extends State<ParkingLocationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic args = ModalRoute.of(context)!.settings.arguments;
      getParkingLocation(args.toString());
    });
  }

  getParkingLocation(String id) async {
    await Provider.of<ParkingLocationViewModel>(context, listen: false)
        .getParkingLocation(id);
  }

  @override
  Widget build(BuildContext context) {
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
        body: Provider.of<ParkingLocationViewModel>(context).isLoading
            ? const LoadingScreen()
            : Consumer<ParkingLocationViewModel>(
                builder: (context, value, child) {
                  return GoogleMapView(
                    markers: {
                      Marker(
                        markerId: MarkerId(
                          value.parkingLocation!.latitude.toString(),
                        ),
                        position: LatLng(
                          value.parkingLocation!.latitude!,
                          value.parkingLocation!.longitude!,
                        ),
                      ),
                    },
                    onTap: () {},
                    cameraPosition: CameraPosition(
                      target: LatLng(
                        value.parkingLocation!.latitude!,
                        value.parkingLocation!.longitude!,
                      ),
                      zoom: 14.5,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
