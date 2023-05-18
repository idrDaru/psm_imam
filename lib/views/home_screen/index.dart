import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/sidebar.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> controller = Completer();

  static const LatLng sourceLocation = LatLng(1.572818, 103.620371);
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUserData();
    });
    getCurrentLocation();
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Consumer<UserProvider>(builder: (context, value, child) {
        return const Sidebar();
      }),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          currentLocation == null
              ? Center(
                  child: Text("LOADING"),
                )
              : GoogleMap(
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                    zoom: 14.5,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("source"),
                      position: LatLng(
                        currentLocation!.latitude!,
                        currentLocation!.longitude!,
                      ),
                    ),
                  },
                ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          child: TextField(
                            onChanged: (value) {},
                            decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Search location',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                borderSide: BorderSide(
                                    color: kPrimaryColor, width: 3.0),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        iconSize: 30.0,
                        onPressed: () {},
                        color: kPrimaryColor,
                        icon: const Icon(
                          Icons.search_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
