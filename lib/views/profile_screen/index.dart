// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psm_imam/components/custom_scaffold.dart';
import 'package:psm_imam/components/loading.dart';
import 'package:psm_imam/models/booking.dart';
import 'package:psm_imam/models/parking_spaces.dart';
import 'package:psm_imam/models/parking_user.dart';
import 'package:psm_imam/components/constants.dart';
import 'package:psm_imam/providers/user_provider.dart';
import 'package:psm_imam/view_models/profile_view_model.dart';
import 'package:psm_imam/views/edit_profile_screen/index.dart';

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, List<dynamic>> datas = {};
  List<ParkingSpace>? parkingSpaceList;
  List<Booking>? bookingList;
  dynamic user;

  String count1 = "0", count2 = "0";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      getProfileScreenData();
    });
  }

  getProfileScreenData() async {
    await Provider.of<UserProvider>(context, listen: false).getUser();
    if (Provider.of<UserProvider>(context, listen: false).user is ParkingUser) {
      await Provider.of<ProfileViewModel>(context, listen: false)
          .getBookingList();

      setState(() {
        bookingList =
            Provider.of<ProfileViewModel>(context, listen: false).bookingList;
        count1 = bookingList!
            .where((element) => element.isPurchased == false)
            .length
            .toString();
        count2 = bookingList!
            .where(
              (element) =>
                  element.isPurchased == true &&
                  element.timeFrom!.isAfter(DateTime.now()),
            )
            .length
            .toString();
      });
    } else {
      await Provider.of<ProfileViewModel>(context, listen: false)
          .getParkingSpaceList();

      setState(() {
        parkingSpaceList = Provider.of<ProfileViewModel>(context, listen: false)
            .parkingSpaceList;
        count1 = parkingSpaceList!
            .where((element) => element.isActive == true)
            .length
            .toString();
        count2 = parkingSpaceList!
            .where((element) => element.isActive == false)
            .length
            .toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return CustomScaffold1(
      body: Provider.of<UserProvider>(context).isLoading ||
              Provider.of<ProfileViewModel>(context).isLoading
          ? const LoadingScreen()
          : ListView(
              padding: const EdgeInsets.only(top: 0),
              children: [
                Stack(
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
                                    return Text(
                                      value.user is ParkingUser
                                          ? 'Waiting for Payment'
                                          : 'Active Parking Spaces',
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
                            return value.user is ParkingUser
                                ? ParkingUserScrolledRow(
                                    bookingList: bookingList,
                                  )
                                : ProviderScrolledRow(
                                    parkingSpaceList: parkingSpaceList,
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
  const ProviderScrolledRow({super.key, required this.parkingSpaceList});

  final List<ParkingSpace>? parkingSpaceList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitledScrolledRow(
          data: parkingSpaceList!.where((c) => c.isActive == true).toList(),
          title: "Active Parking Space",
        ),
        TitledScrolledRow(
          data: parkingSpaceList!.where((c) => c.isActive == false).toList(),
          title: "Deactivated Parking Spaces",
        ),
      ],
    );
  }
}

class ParkingUserScrolledRow extends StatelessWidget {
  const ParkingUserScrolledRow({super.key, required this.bookingList});
  final List<Booking>? bookingList;

  List<dynamic> filterUpcomingParking() {
    List<dynamic> result = [];

    List tmpResult = bookingList!
        .where(
            (c) => c.isPurchased == true && c.timeFrom!.isAfter(DateTime.now()))
        .toList();
    for (var element in tmpResult) {
      result.add(element.parkingSpace);
    }

    return result;
  }

  List<dynamic> filterWaitingForPayment() {
    List<dynamic> result = [];

    List tmpResult = bookingList!
        .where(
          (c) =>
              c.isPurchased == false &&
              c.timeFrom!.isAfter(
                DateTime.now(),
              ),
        )
        .toList();
    for (var element in tmpResult) {
      result.add(element.parkingSpace);
    }

    return result;
  }

  List<dynamic> filterHistoryParking() {
    List<dynamic> result = [];

    List tmpResult = bookingList!
        .where((c) =>
            c.isPurchased == true && c.timeFrom!.isBefore(DateTime.now()))
        .toList();
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
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
