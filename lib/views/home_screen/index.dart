// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/components/map.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/view_models/home_view_model.dart';
import 'package:psm_imam/views/add_booking_screen/index.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/sidebar.dart';
import 'package:psm_imam/views/parking_layout_screen/index.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ParkingSpace> parkingSpace = [];

  final Completer<GoogleMapController> controller = Completer();
  LocationData? currentLocation;
  bool isPopUp = false;
  dynamic _onTapData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getHomeScreenData();
    });
    getCurrentLocation();
  }

  getHomeScreenData() async {
    await Provider.of<HomeViewModel>(context, listen: false).getUser();
    await Provider.of<HomeViewModel>(context, listen: false)
        .getAllParkingSpace();

    setState(() {
      parkingSpace =
          Provider.of<HomeViewModel>(context, listen: false).parkingSpace;
    });
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
    });
  }

  Set<Marker> markers() {
    Set<Marker> result = {};
    for (var i = 0; i < parkingSpace.length; i++) {
      result.add(
        Marker(
          markerId:
              MarkerId(parkingSpace[i].parkingLocation!.latitude.toString()),
          position: LatLng(
            parkingSpace[i].parkingLocation!.latitude!.toDouble(),
            parkingSpace[i].parkingLocation!.longitude!.toDouble(),
          ),
          onTap: () {
            setState(() {
              isPopUp = !isPopUp;
              _onTapData = parkingSpace[i];
            });
          },
        ),
      );
    }
    return result;
  }

  Widget handlePopUpWidget(dynamic data) {
    return ParkingSpaceDetail(data: data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: kPrimaryColor,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const Sidebar(),
        extendBodyBehindAppBar: true,
        body: currentLocation == null ||
                Provider.of<HomeViewModel>(context).isLoading
            ? const LoadingScreen()
            : Stack(
                children: [
                  GoogleMapView(
                    markers: markers(),
                    onTap: () {},
                    cameraPosition: CameraPosition(
                      target: LatLng(
                        currentLocation!.latitude!,
                        currentLocation!.longitude!,
                      ),
                      zoom: 14.5,
                    ),
                  ),
                  !isPopUp
                      ? const SizedBox.shrink()
                      : handlePopUpWidget(_onTapData),
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
                                          color: kPrimaryColor,
                                          width: 3.0,
                                        ),
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
      ),
    );
  }
}

// ignore: must_be_immutable
class ParkingSpaceDetail extends StatelessWidget {
  ParkingSpaceDetail({super.key, required this.data});

  ParkingSpace data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.8,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: kSecondaryColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Text(
              data.name!,
              style: kTitleTextStyle,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              '${data.addressLineOne}, ${data.addressLineTwo}, ${data.postalCode} ${data.city}, ${data.stateProvince}, ${data.country}',
              style: kTextStyle.copyWith(fontSize: 13.0),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Car",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
                Text(
                  ": RM ${data.parkingLayout!.carPrice}",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
                Text(
                  "Per Hour",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Motorcycle",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
                Text(
                  ": RM ${data.parkingLayout!.motorcyclePrice}",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
                Text(
                  "Per Hour",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2.0,
                color: kSecondaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Empty Car Space",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
                Text(
                  ": ${data.parkingLayout!.parkingSpot!.where((c) => c.status == true && c.type == 2).length}",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2.0,
                color: kSecondaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Empty Motorcycle Space",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
                Text(
                  ": ${data.parkingLayout!.parkingSpot!.where((c) => c.status == true && c.type == 1).length}",
                  style: kTextStyle.copyWith(fontSize: 13.0),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2.0,
                color: kSecondaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ParkingLayoutScreen.id,
                        arguments: {
                          "parkingLayout": data.parkingLayout,
                          "isEditable": false,
                        },
                      );
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        kSecondaryColor,
                      ),
                    ),
                    child: Text(
                      'Parking Layout',
                      style: kTextStyle.copyWith(fontSize: 8.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AddBookingScreen.id,
                  arguments: data,
                );
              },
              style: kSendButtonStyle,
              child: const Text("Order"),
            ),
          ],
        ),
      ),
    );
  }
}
