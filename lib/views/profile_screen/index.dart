// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/providers/booking_provider.dart';
import 'package:psm_imam/providers/parking_space_provider.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/components/sidebar.dart';
import 'package:psm_imam/views/edit_profile_screen/index.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, List<dynamic>> datas = {};
  List<ParkingSpace> parkingSpaces = [];
  dynamic _data;

  String count1 = "0", count2 = "0";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      fetchProfileData();
    });
  }

  void fetchProfileData() async {
    await Provider.of<UserProvider>(context, listen: false).getUserData();

    if (Provider.of<UserProvider>(context, listen: false).user is ParkingUser) {
      await Provider.of<BookingProvider>(context, listen: false)
          .getUserBooking();

      _data = Provider.of<BookingProvider>(context, listen: false).booking;
      setState(() {
        count1 = _data.where((c) => c.isPurchased == false).length.toString();
        count2 = _data.where((c) => c.isPurchased == true).length.toString();
      });
    } else {
      await Provider.of<ParkingSpaceProvider>(context, listen: false)
          .getProviderParkingSpaceData();

      _data = Provider.of<ParkingSpaceProvider>(context, listen: false)
          .parkingSpace;
      setState(() {
        count1 = _data.length.toString();
        count2 = _data.where((c) => c.isActive == false).length.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Consumer<UserProvider>(builder: (context, value, child) {
          return const Sidebar();
        }),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kPrimaryColor),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: [
            Provider.of<UserProvider>(context).isLoading ||
                    Provider.of<BookingProvider>(context).isLoading ||
                    Provider.of<ParkingSpaceProvider>(context).isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      const ProfileHeader(),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          top: 50,
                          bottom: 20,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Consumer<UserProvider>(
                                builder: (context, value, child) {
                                  return Text(
                                    value.user is ParkingUser
                                        ? "PROFILE"
                                        : "PROVIDER",
                                    style: kTitleTextStyle,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 30.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<UserProvider>(
                                    builder: (context, value, child) {
                                      return CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(
                                          value.user.user.imageDownloadURL,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 20.0),
                                  Flexible(
                                    child: Consumer<UserProvider>(
                                      builder: (context, value, child) {
                                        return Text(
                                          value.user is ParkingUser
                                              ? '${value.user.firstName} ${value.user.lastName}'
                                              : '${value.user.name}',
                                          style: kTitleTextStyle,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      count1,
                                      style: kTitleTextStyle.copyWith(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context, value, child) {
                                      if (value.isLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Text(
                                        value.user is ParkingUser
                                            ? 'Waiting for Payment'
                                            : 'Parking Spaces',
                                        style:
                                            kTextStyle.copyWith(fontSize: 12.0),
                                      );
                                    }),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      count2,
                                      style: kTitleTextStyle.copyWith(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Consumer<UserProvider>(
                                        builder: (context, value, child) {
                                      if (value.isLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Text(
                                        value.user is ParkingUser
                                            ? 'Upcoming Parking'
                                            : 'Deactivated',
                                        style:
                                            kTextStyle.copyWith(fontSize: 12.0),
                                      );
                                    })
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      EditProfileScreen.id,
                                      arguments: Provider.of<UserProvider>(
                                        context,
                                        listen: false,
                                      ).user,
                                    );
                                  },
                                  style: kSendButtonStyle.copyWith(
                                    padding: const MaterialStatePropertyAll<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 25.0,
                                      ),
                                    ),
                                  ),
                                  child: const Text('Edit Profile'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height / 2.3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30.0,
                            horizontal: 20.0,
                          ),
                          child: Consumer<UserProvider>(
                            builder: (context, value, child) {
                              Widget result;
                              value.user is ParkingUser
                                  ? result = ParkingUserScrolledRow(data: _data)
                                  : result = ProviderScrolledRow(data: _data);
                              return result;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 2,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Background.png'),
          fit: BoxFit.cover,
        ),
        color: kSecondaryColor,
      ),
    );
  }
}

class ProviderScrolledRow extends StatelessWidget {
  const ProviderScrolledRow({super.key, required this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitledScrolledRow(
          data: data.where((c) => c.isActive == true).toList(),
          title: "My Parking Space",
        ),
        TitledScrolledRow(
          data: data.where((c) => c.isActive == false).toList(),
          title: "Deactivated Parking Spaces",
        ),
      ],
    );
  }
}

class ParkingUserScrolledRow extends StatelessWidget {
  const ParkingUserScrolledRow({super.key, required this.data});
  final dynamic data;

  List<dynamic> filterUpcomingParking() {
    List<dynamic> result = [];

    List tmpResult = data.where((c) => c.isPurchased == true).toList();
    for (var element in tmpResult) {
      result.add(element.parkingSpace);
    }

    return result;
  }

  List<dynamic> filterWaitingForPayment() {
    List<dynamic> result = [];

    List tmpResult = data.where((c) => c.isPurchased == false).toList();
    for (var element in tmpResult) {
      result.add(element.parkingSpace);
    }

    return result;
  }

  List<dynamic> filterHistoryParking() {
    List<dynamic> result = [];

    List tmpResult = data.toList();
    for (var element in tmpResult) {
      result.add(element.parkingSpace);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitledScrolledRow(
          data: filterUpcomingParking(),
          title: "My Upcoming Parking",
        ),
        TitledScrolledRow(
          data: filterWaitingForPayment(),
          title: "Waiting for Payment",
        ),
        TitledScrolledRow(
          data: filterHistoryParking(),
          title: "My Parking History",
        ),
      ],
    );
  }
}

class TitledScrolledRow extends StatelessWidget {
  const TitledScrolledRow({super.key, required this.data, required this.title});

  final dynamic data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        Text(
          title,
          style: kTitleTextStyle,
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  ScrolledRow(data: data[index]),
                  const SizedBox(width: 20.0),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class ScrolledRow extends StatelessWidget {
  const ScrolledRow({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
            data.imageDownloadUrl,
            // 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
