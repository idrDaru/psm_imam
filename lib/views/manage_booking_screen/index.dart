import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/views/components/constants.dart';
import 'package:psm_imam/views/components/header.dart';
import 'package:psm_imam/views/components/sidebar.dart';
import 'package:psm_imam/views/edit_booking_screen/index.dart';
import 'package:psm_imam/views/payment_method_screen/index.dart';

class ManageBookingScreen extends StatefulWidget {
  static String id = 'manage_booking_screen';
  const ManageBookingScreen({super.key});

  @override
  State<ManageBookingScreen> createState() => _ManageBookingScreenState();
}

class _ManageBookingScreenState extends State<ManageBookingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const Sidebar(),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
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
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/194/194938.png',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                            kSecondaryColor,
                                          ),
                                        ),
                                        child: Text(
                                          'Parking Layout',
                                          style:
                                              kTextStyle.copyWith(fontSize: 10.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                            kSecondaryColor,
                                          ),
                                        ),
                                        child: Text(
                                          'Parking Location',
                                          style:
                                              kTextStyle.copyWith(fontSize: 10.0),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fakulti Alam Bina dan Ukur',
                                        style: kTitleTextStyle.copyWith(
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        'Fakulti Alam Bina dan Ukur, Lingkaran Ilmu, Universiti Teknologi Malaysia, 81310 Johor Bahru, Johor, Malaysia',
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
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Car Space : 1',
                                                style: kTextStyle.copyWith(
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                'Motorcycle Space : 0',
                                                style: kTextStyle.copyWith(
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                              Text(
                                                'Parking Layout : 87',
                                                style: kTextStyle.copyWith(
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                              const SizedBox(height: 5.0),
                                            ],
                                          ),
                                          Text(
                                            'Total Price : RM 1',
                                            style: kTextStyle.copyWith(
                                                color: kPrimaryColor,
                                                fontSize: 11.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    style: kTextStyle.copyWith(fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, EditBookingScreen.id);
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
                                      fontSize: 12.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      PaymentMethodScreen.id,
                                    );
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                      kPrimaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    'Pay',
                                    style: kTextStyle.copyWith(
                                      color: Colors.white,
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
