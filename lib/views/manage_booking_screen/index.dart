// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/header.dart';
import 'package:psm_imam/components/sidebar.dart';
import 'package:psm_imam/view_models/manage_booking_view_model.dart';
import 'package:psm_imam/views/edit_booking_screen/index.dart';
import 'package:psm_imam/views/parking_layout_screen/index.dart';
import 'package:psm_imam/views/parking_location_screen/index.dart';
import 'package:psm_imam/views/payment_method_screen/index.dart';

class ManageBookingScreen extends StatefulWidget {
  static String id = 'manage_booking_screen';
  const ManageBookingScreen({super.key});

  @override
  State<ManageBookingScreen> createState() => _ManageBookingScreenState();
}

class _ManageBookingScreenState extends State<ManageBookingScreen> {
  List<Booking>? bookingList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      getUserBooking();
    });
  }

  getUserBooking() async {
    await Provider.of<ManageBookingViewModel>(context, listen: false).getUser();
    await Provider.of<ManageBookingViewModel>(context, listen: false)
        .getUserBooking();

    setState(() {
      bookingList = Provider.of<ManageBookingViewModel>(context, listen: false)
          .bookingList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Sidebar(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Provider.of<ManageBookingViewModel>(context).isLoading
            ? const LoadingScreen()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Header(title: 'My Booking'),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: bookingList!.length,
                        itemBuilder: (context, index) {
                          var parkingSpace = bookingList![index].parkingSpace;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            height: 340.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              border: Border.all(
                                width: 2.0,
                                color: kSecondaryColor,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 2.0,
                                                  color: kSecondaryColor,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                radius: 40.0,
                                                backgroundImage: NetworkImage(
                                                  parkingSpace!.imageDownloadUrl
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  ParkingLayoutScreen.id,
                                                  arguments: {
                                                    "parkingLayout":
                                                        parkingSpace
                                                            .parkingLayout,
                                                    "isEditable": false,
                                                  },
                                                );
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<
                                                        Color>(
                                                  kSecondaryColor,
                                                ),
                                              ),
                                              child: Text(
                                                'Parking Layout',
                                                style: kTextStyle.copyWith(
                                                    fontSize: 10.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(height: 10.0),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  ParkingLocationScreen.id,
                                                  arguments: parkingSpace
                                                      .parkingLocation,
                                                );
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll<
                                                        Color>(
                                                  kSecondaryColor,
                                                ),
                                              ),
                                              child: Text(
                                                'Parking Location',
                                                style: kTextStyle.copyWith(
                                                    fontSize: 10.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              parkingSpace.name.toString(),
                                              style: kTitleTextStyle.copyWith(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            Text(
                                              '${parkingSpace.addressLineOne}, ${parkingSpace.addressLineTwo}, ${parkingSpace.postalCode} ${parkingSpace.city}, ${parkingSpace.stateProvince}, ${parkingSpace.country}',
                                              style: kTextStyle.copyWith(
                                                fontSize: 11.0,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            const SizedBox(height: 20.0),
                                            Text(
                                              'Booking Information',
                                              style: kTitleTextStyle.copyWith(
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Car Space : ${bookingList![index].totalCar.toString()}',
                                                      style:
                                                          kTextStyle.copyWith(
                                                        fontSize: 11.0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5.0),
                                                    Text(
                                                      'Motorcycle Space : ${bookingList![index].totalMotorcycle.toString()}',
                                                      style:
                                                          kTextStyle.copyWith(
                                                        fontSize: 11.0,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5.0),
                                                  ],
                                                ),
                                                Text(
                                                  'Total Price : RM ${bookingList![index].totalPrice.toString()}',
                                                  style: kTextStyle.copyWith(
                                                    color: kPrimaryColor,
                                                    fontSize: 11.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                            kSecondaryColor,
                                          ),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: kTextStyle.copyWith(
                                            color:
                                                bookingList![index].isPurchased!
                                                    ? Colors.grey
                                                    : Colors.black,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          bookingList![index].isPurchased!
                                              ? null
                                              : Navigator.pushNamed(
                                                  context,
                                                  EditBookingScreen.id,
                                                  arguments:
                                                      bookingList![index],
                                                );
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                            kSecondaryColor,
                                          ),
                                        ),
                                        child: Text(
                                          'Edit Booking',
                                          style: kTextStyle.copyWith(
                                            color:
                                                bookingList![index].isPurchased!
                                                    ? Colors.grey
                                                    : Colors.black,
                                            fontSize: 12.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          bookingList![index].isPurchased!
                                              ? null
                                              : Navigator.pushNamed(
                                                  context,
                                                  PaymentMethodScreen.id,
                                                  arguments:
                                                      bookingList![index],
                                                );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: bookingList![index]
                                                  .isPurchased!
                                              ? const MaterialStatePropertyAll<
                                                  Color>(kSecondaryColor)
                                              : const MaterialStatePropertyAll<
                                                  Color>(kPrimaryColor),
                                        ),
                                        child: Text(
                                          bookingList![index].isPurchased!
                                              ? 'Paid'
                                              : 'Pay',
                                          style: kTextStyle.copyWith(
                                            color:
                                                bookingList![index].isPurchased!
                                                    ? Colors.grey
                                                    : Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
      ),
    );
  }
}
