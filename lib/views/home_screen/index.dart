import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/view_models/home_view_model.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/sidebar.dart';
import 'package:psm_imam/views/components/submit_button.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _data;
  final Completer<GoogleMapController> controller = Completer();
  LocationData? currentLocation;
  bool isPopUp = false;
  dynamic _onTapData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUserData();
    });
    getCurrentLocation();
    getAllParkingSpaceLocations();
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
    });
  }

  Future<void> getAllParkingSpaceLocations() async {
    var homeViewModel = HomeViewModel();
    var tmp = await homeViewModel.getAllParkingLocations();
    setState(() {
      _data = tmp;
    });
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
        drawer: Consumer<UserProvider>(builder: (context, value, child) {
          return const Sidebar();
        }),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            currentLocation == null || _data == null
                ? const Center(
                    child: Text("LOADING"),
                  )
                : GoogleMap(
                    myLocationEnabled: true,
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
                      for (var i = 0; i < _data.length; i++)
                        Marker(
                          markerId: MarkerId(_data[i].latitude.toString()),
                          position: LatLng(
                            _data[i].latitude,
                            _data[i].longitude,
                          ),
                          onTap: () {
                            setState(() {
                              isPopUp = !isPopUp;
                              _onTapData = _data[i];
                            });
                          },
                        ),
                    },
                  ),
            !isPopUp ? const SizedBox.shrink() : handlePopUpWidget(_onTapData),
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

class ParkingSpaceDetail extends StatelessWidget {
  ParkingSpaceDetail({super.key, required this.data});

  dynamic data;

  @override
  Widget build(BuildContext context) {
    var parkingSpace = data.parkingSpace;
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
              parkingSpace.name,
              style: kTitleTextStyle,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              '${parkingSpace.addressLineOne}, ${parkingSpace.addressLineTwo}, ${parkingSpace.postalCode} ${parkingSpace.city}, ${parkingSpace.stateProvince}, ${parkingSpace.country}',
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
                  ": RM 1",
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
                  ": RM 0.5",
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
                  ": 10",
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
                  ": 50",
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
                    onPressed: () {},
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
              onPressed: () {},
              style: kSendButtonStyle,
              child: const Text("Order"),
            ),
          ],
        ),
      ),
    );
  }
}
